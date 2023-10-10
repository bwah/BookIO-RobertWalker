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
    func asData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
