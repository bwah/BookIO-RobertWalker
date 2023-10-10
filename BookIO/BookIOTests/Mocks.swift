//
//  Mocks.swift
//  BookIOTests
//
//  Created by Robert Walker on 10/9/23.
//

import Foundation
@testable import BookIO

class MockKeychainHelper: KeychainCredentialsHelper {
    var savedCredentials: Credentials? = nil

    override func retrieveFromKeychain() -> Credentials? {
        return savedCredentials
    }

    override func saveCredentials(_ creds: Credentials) {
        savedCredentials = creds
    }

    override func removeCredentials() {
        savedCredentials = nil
    }
}

class MockJsonHttp: JsonHttp {
    let queue = DispatchSerialQueue(label: "test.mockHttp.queue")
    var urlToReturnObjectMap: [String: Decodable] = [:]
    var requestedUrlSet = Set<String>()
    var postSuccess: Bool = true

    override func get<T>(url: URL, type: T.Type) async throws -> T where T : Decodable {
        var retObj: T?
        try queue.sync {
            requestedUrlSet.insert(url.absoluteString)
            guard let getReturnObject = urlToReturnObjectMap[url.absoluteString] else {
                throw HttpError.httpError
            }

            retObj = getReturnObject as? T
        }

        return retObj!
    }

    override func post(url: URL, body: Encodable) async throws -> Data {
        try queue.sync {
            requestedUrlSet.insert(url.absoluteString)
            guard postSuccess == true else {
                throw HttpError.httpError
            }


        }
        return Data()
    }
}
