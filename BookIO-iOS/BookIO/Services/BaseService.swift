//
//  BaseService.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import Foundation

enum ServiceError: Error {
    case network, config, unknown
}

class Service: ObservableObject {
    @Published var loading: Bool = false

    static let baseUrlString = BookIOApp.appConfig.apiBaseUrl
    let jsonHttp: JsonHttp

    init(jsonHttp: JsonHttp = JsonHttp()) {
        self.jsonHttp = jsonHttp
    }

    func buildApiUrlFromPath(_ path: String) throws -> URL {
        guard let url = URL(string: Service.baseUrlString + path) else {
            throw ServiceError.config
        }

        return url
    }

    @MainActor func setLoading(_ loading: Bool) {
        self.loading = loading
    }
}
