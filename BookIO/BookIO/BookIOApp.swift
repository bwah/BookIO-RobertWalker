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
//    @StateObject var authService = AuthService()

    var body: some Scene {
        WindowGroup {

            RootView()
//                .environmentObject(authService)
//            VStack {
//                if let credentials = authService.credentials {
//                    Text("username: \(credentials.username) password: \(credentials.password)")
//                } else {
//                    Text("We are not authed")
//                }
//            }.onAppear {
////                authService.authAfterDelay()
////                if let creds = try! Credentials.retrieveFromKeychain() {
////                    print(creds)
////                } else {
////                    print("no credentials found")
////                }
////                let creds = Credentials(username: "bwah", password: "test1234")
////                try! creds.saveToKeychain()
////                Credentials.removeFromKeychain()
//
//            }
        }
    }

//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "We need to authenticate for login"
//
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
//                if success {
//                    isUnlocked = true
//
//                } else {
//                    isUnlocked = false
//                }
//            }
//        } else {
//            isUnlocked = false
//        }
//    }
}


