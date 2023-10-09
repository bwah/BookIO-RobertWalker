//
//  LoginView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authService: AuthService
    @State var showLoginFailure = false
    @State var username = ""
    @State var password = ""

    init(authService: AuthService) {
        self.authService = authService
    }

    var body: some View {
        VStack {
            Text("Login")
                .padding()

            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .padding()
            SecureField("Password", text: $password)
                .padding()

            Button {
                attemptLoginWith(username: username, password: password)
            } label: {
                Text("Login")
            }
            .disabled(authService.loading)
            .padding()

            if authService.loading {
                ProgressView()
                    .padding()
            }

            if showLoginFailure {
                Text("Unable to login, please try again")
                    .padding()
            }
        }
        .interactiveDismissDisabled()
    }

    private func attemptLoginWith(username: String, password: String) {
        Task {
            setLoginFailure(visible: false)
            let authResult = await authService.loginWith(Credentials(username: username, password: password))
            setLoginFailure(visible: authResult == .failure)
        }
    }

    @MainActor private func setLoginFailure(visible: Bool) {
        showLoginFailure = visible
    }
}
