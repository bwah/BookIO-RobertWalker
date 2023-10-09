//
//  Credentials.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import Foundation

struct Credentials: Codable {
    let username: String
    let password: String
}

extension Credentials {
    static func retrieveFromKeychain() throws -> Credentials? {
        guard let data = KeychainAccessor.read() else {
            return nil
        }
        print("got creds")
        return try JSONDecoder().decode(Credentials.self, from: data)
    }

    static func removeFromKeychain() {
        KeychainAccessor.delete()
    }

    func saveToKeychain() throws {
        let data = try self.asData()
        KeychainAccessor.save(data: data)
    }

    private func asData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
