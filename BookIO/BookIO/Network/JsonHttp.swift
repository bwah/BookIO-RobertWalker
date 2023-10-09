//
//  JsonHttp.swift
//  BookIO
//
//  Created by Robert Walker on 10/6/23.
//

import Foundation

enum HttpError: Error {
    case httpError
}

class JsonHttp {

    private let session = URLSession.shared

    func get<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(type, from: data)
    }

    func post(url: URL, body: Encodable) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(body)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        let (data, response) = try await session.data(for: urlRequest)

        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode < 200 || httpResponse.statusCode > 299 {
                throw HttpError.httpError
            }
        }

        return data
    }

    func post<T: Decodable>(url: URL, body: Encodable, type: T.Type) async throws -> T {
        let data = try await post(url: url, body: body)
        return try JSONDecoder().decode(type, from: data)
    }
}
