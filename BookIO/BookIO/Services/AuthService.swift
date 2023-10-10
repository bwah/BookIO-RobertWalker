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
    let keychainHelper: KeychainCredentialsHelper
    var credentials: Credentials? = nil
    var username: String? {
        return credentials?.username
    }
    @Published var authed: Bool = false

    init(jsonHttp: JsonHttp = JsonHttp(), keychainHelper: KeychainCredentialsHelper = KeychainCredentialsHelper()) {
        self.keychainHelper = keychainHelper

        super.init(jsonHttp: jsonHttp)
    }

    func attemptLoginFromKeychain() {
        if let creds = keychainHelper.retrieveFromKeychain() {
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

    func createAccountWith(_ creds: Credentials) async -> AuthResult {
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

    @MainActor private func setStateAsAuthenticated(creds: Credentials) {
        credentials = creds
        authed = true
        setLoading(false)
        keychainHelper.saveCredentials(creds)
    }

    @MainActor private func setStateAsUnAuthenticated() {
        credentials = nil
        authed = false
        setLoading(false)
        keychainHelper.removeCredentials()
    }

    func logout() {
        Task {
            await setStateAsUnAuthenticated()
        }
    }
}
