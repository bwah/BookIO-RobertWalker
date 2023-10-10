//
//  AppConfig.swift
//  BookIO
//
//  Created by Robert Walker on 10/6/23.
//

import Foundation

struct AppConfig {
    let apiBaseUrl: String
}

extension AppConfig {
    static func createFromBundle() -> AppConfig {
        guard let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String else {
            fatalError("Invalid base url from bundle configuration")
        }

        return AppConfig(apiBaseUrl: apiBaseUrl)
    }
}
