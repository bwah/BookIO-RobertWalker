//
//  NewAccountView.swift
//  BookIO
//
//  Created by Robert Walker on 10/9/23.
//

import SwiftUI

struct NewAccountView: View {
    @ObservedObject private var authService: AuthService
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var showErrorMessage = false
    @State private var showPasswordMismatchMessage = false

    init(authService: AuthService) {
        self.authService = authService
    }

    var body: some View {
        VStack {
            Text("Enter a username and password to create an account")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))

            BorderedTextField(text: $username, placeholder: "Username")
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $password, placeholder: "Password", secure: true)
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $passwordConfirm, placeholder: "Confirm Password", secure: true)

            BorderedButton(title: "Create Account") {
                createAccount()
            }
            .disabled(authService.loading)
            .padding()

            if showErrorMessage {
                ErrorText(text: "Account creation failed, please try again...")
            }

            if showPasswordMismatchMessage {
                ErrorText(text: "Please check your password values...")
            }

            Spacer()
        }.padding()
    }

    private func createAccount() {
        guard username.isEmpty == false, 
                password.isEmpty == false else {
            return
        }

        guard password == passwordConfirm else {
            showPasswordMismatchMessage = true
            return
        }

        showPasswordMismatchMessage = false

        Task {
            setErrorMessage(visible: false)
            let authResult = await authService.createAccount(creds: Credentials(username: username, password: password))
            setErrorMessage(visible: authResult == .failure)
        }
    }

    @MainActor private func setErrorMessage(visible: Bool) {
        showErrorMessage = visible
    }
}
