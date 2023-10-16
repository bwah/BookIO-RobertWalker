//
//  BookIOApp.swift
//  BookIO
//
//  Created by Robert Walker on 10/6/23.
//

import SwiftUI

@main
struct BookIOApp: App {
    static let appConfig = AppConfig.createFromBundle()

    var body: some Scene {
        WindowGroup {

            RootView()
        }
    }
}


