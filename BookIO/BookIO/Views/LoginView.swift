//
//  LoginView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authService: AuthService
    @State var showErrorMessage = false
    @State var showingNewAccountSheet = false
    @State var username = ""
    @State var password = ""

    init(authService: AuthService) {
        self.authService = authService
    }

    var body: some View {
        VStack {
            if authService.loading {
                ProgressView()
                    .padding()

                Text("Logging in...")
            } else {
                loginFieldsView
                Spacer()
            }
        }
        .padding()
    }

    private var loginFieldsView: some View {
        VStack {
            Text("Login with your Username and Password")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))

            BorderedTextField(text: $username, placeholder: "Username")
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $password, placeholder: "Password", secure: true)
                .disabled(authService.loading)

            BorderedButton(title: "Login to Your Account") {
                attemptLoginWith(username: username, password: password)
            }
            .disabled(authService.loading)
            .frame(maxWidth: .infinity)
            .padding()

            Button("Create New Account") {
                showingNewAccountSheet = true
            }

            if showErrorMessage {
                ErrorText(text: "Unable to login, please try again")
            }
        }
        .sheet(isPresented: $showingNewAccountSheet) {
            NewAccountView(authService: authService)
        }
    }

    private func attemptLoginWith(username: String, password: String) {
        guard username.isEmpty == false && password.isEmpty == false else {
            return
        }

        Task {
            setErrorMessage(visible: false)
            let authResult = await authService.loginWith(Credentials(username: username, password: password))
            setErrorMessage(visible: authResult == .failure)
        }
    }

    @MainActor private func setErrorMessage(visible: Bool) {
        showErrorMessage = visible
    }
}
