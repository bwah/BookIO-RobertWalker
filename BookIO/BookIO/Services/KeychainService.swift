//
//  KeychainService.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import Foundation
import AuthenticationServices

class KeychainCredentialsHelper {
    func retrieveFromKeychain() -> Credentials? {
        guard let data = KeychainAccessor.read() else {
            return nil
        }
        return try? JSONDecoder().decode(Credentials.self, from: data)
    }

    func saveCredentials(_ creds: Credentials) {
        if let data = try? creds.asData() {
            KeychainAccessor.save(data: data)
        }
    }

    func removeCredentials() {
        KeychainAccessor.delete()
    }
}

class KeychainAccessor {
    private static let service = "com.bookio.service"
    private static let account = "com.bookio.account"
    private static var accessControl = {
        return SecAccessControlCreateWithFlags(
            nil,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            .biometryCurrentSet,
            nil)!
    }()

    static func save(data: Data) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecAttrAccessControl: accessControl,
            kSecReturnData: true
        ] as CFDictionary

        let saveStatus = SecItemAdd(query, nil)

        if saveStatus == errSecDuplicateItem {
            update(data: data)
        }
    }

    static func update(data: Data) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecAttrAccessControl: accessControl,
            kSecReturnData: true
        ] as CFDictionary

        let updatedData = [kSecValueData: data] as CFDictionary
        SecItemUpdate(query, updatedData)
    }

    static func read() -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }

    static func delete() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        SecItemDelete(query)
    }
}
