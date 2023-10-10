//
//  NewAccountView.swift
//  BookIO
//
//  Created by Robert Walker on 10/9/23.
//

import SwiftUI

struct NewAccountView: View {
    @Environment(\.dismiss) var dismiss
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
            
            AppTitleView()

            Text("Enter a username and password to create an account")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            BorderedTextField(text: $username, placeholder: "Username")
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $password, placeholder: "Password", secure: true)
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $passwordConfirm, placeholder: "Confirm Password", secure: true)

            BorderedButton(title: "Create Account", color: createEnabled() ? .black : .gray) {
                createAccount()
            }
            .disabled(!createEnabled())
            .padding()

            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .underline()
                    .padding()
            }


            if showErrorMessage {
                ErrorText(text: "Account creation failed, please try again...")
            }

            if showPasswordMismatchMessage {
                ErrorText(text: "Please check your password values...")
            }

            Spacer()

        }.padding()
    }

    private func createEnabled() -> Bool {
        return !username.isEmpty
        && !password.isEmpty
        && (password == passwordConfirm)
        && !authService.loading
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
            let authResult = await authService.createAccountWith(Credentials(username: username, password: password))
            setErrorMessage(visible: authResult == .failure)
        }
    }

    @MainActor private func setErrorMessage(visible: Bool) {
        showErrorMessage = visible
    }
}

#Preview {
    NewAccountView(authService: AuthService())
}
