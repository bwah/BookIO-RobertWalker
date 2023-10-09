//
//  AuthService.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import Foundation

enum AuthResult {
    case success, failure
}

class AuthService: Service {
    var credentials: Credentials? = nil
    var username: String? {
        return credentials?.username
    }
    var authed: Bool {
        return credentials != nil
    }
    
    @Published var needsLogin: Bool = true
    @Published var loggingIn: Bool = false

    override init(jsonHttp: JsonHttp = JsonHttp()) {
        super.init(jsonHttp: jsonHttp)

        if let creds = try? Credentials.retrieveFromKeychain() {
            Task {
                await loginWith(creds)
            }
        }
    }

    func loginWith(_ creds: Credentials) async -> AuthResult {
        await setLoading(true)
        do {
            let url = try buildApiUrlFromPath("/login")
            _ = try await jsonHttp.post(url: url, body: creds)
            await setStateAsAuthenticated(creds: creds)
            return .success
        } catch {
            await setStateAsUnAuthenticated()
            return .failure
        }
    }

    @MainActor func setStateAsAuthenticated(creds: Credentials) {
        credentials = creds
        needsLogin = false
        setLoading(false)
        try? credentials?.saveToKeychain()
    }

    @MainActor func setStateAsUnAuthenticated() {
        credentials = nil
        needsLogin = true
        setLoading(false)
        Credentials.removeFromKeychain()
    }

    func logout() {
        Task {
            await setStateAsUnAuthenticated()
        }
    }

//    func authAfterDelay() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.credentials = Credentials(username: "asdf", password: "pass")
//            self.needsLogin = false
//        }
//    }
//
//    func updateCredentials(_ creds: Credentials) {
//        credentials = creds
//        self.needsLogin = false
//    }
}
