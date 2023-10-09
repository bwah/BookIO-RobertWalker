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
    @Published var authed: Bool = false

    override init(jsonHttp: JsonHttp = JsonHttp()) {
        super.init(jsonHttp: jsonHttp)

        if let creds = try? Credentials.retrieveFromKeychain() {
            loading = true
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

    func createAccount(creds: Credentials) async -> AuthResult {
        await setLoading(true)

        do {
            let url = try buildApiUrlFromPath("/users/new")
            _ = try await jsonHttp.post(url: url, body: creds)
            await setStateAsAuthenticated(creds: creds)
            return .success
        } catch {
            await setLoading(false)
            return .failure
        }
    }

    @MainActor func setStateAsAuthenticated(creds: Credentials) {
        credentials = creds
        authed = true
        setLoading(false)
        try? credentials?.saveToKeychain()
    }

    @MainActor func setStateAsUnAuthenticated() {
        credentials = nil
        authed = false
        setLoading(false)
        Credentials.removeFromKeychain()
    }

    func logout() {
        Task {
            await setStateAsUnAuthenticated()
        }
    }
}
