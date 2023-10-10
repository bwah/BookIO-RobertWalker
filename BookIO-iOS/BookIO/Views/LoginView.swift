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
                LoadingView(text: "Logging in...")
            } else {
                loginFieldsView
                Spacer()
            }
        }
        .padding()
    }

    private var loginFieldsView: some View {
        VStack {

            AppTitleView()

            Text("Login with your Username and Password")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            BorderedTextField(text: $username, placeholder: "Username")
                .disabled(authService.loading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))

            BorderedTextField(text: $password, placeholder: "Password", secure: true)
                .disabled(authService.loading)

            BorderedButton(title: "Login to Your Account", color: loginEnabled() ? .black : .gray) {
                attemptLoginWith(username: username, password: password)
            }
            .disabled(!loginEnabled())
            .frame(maxWidth: .infinity)
            .padding()

            Text("or")

            Button {
                showingNewAccountSheet = true
            } label: {
                Text("Create New Account")
                    .underline()
                    .padding()
            }

            if showErrorMessage {
                ErrorText(text: "Unable to login, please try again")
            }

            Spacer()
        }
        .sheet(isPresented: $showingNewAccountSheet) {
            NewAccountView(authService: authService)
        }
    }

    private func loginEnabled() -> Bool {
        return !username.isEmpty && !password.isEmpty && !authService.loading
    }

    private func attemptLoginWith(username: String, password: String) {
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

#Preview {
    LoginView(authService: AuthService())
}
