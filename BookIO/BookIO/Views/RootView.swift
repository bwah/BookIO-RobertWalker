//
//  RootView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject private var authService: AuthService
    @State private var showingProfileOptions = false
    private let booksListViewModel: BooksMainViewModel

    init() {
        let authService = AuthService()
        self.authService = authService
        self.booksListViewModel = BooksMainViewModel(authService: authService)

        self.authService.attemptLoginFromKeychain()
    }

    var body: some View {
        NavigationStack {
            if authService.authed {
                BooksMainView(viewModel: booksListViewModel)
                    .navigationTitle("Books")
                    .toolbar {
                        Button {
                            showingProfileOptions = true
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
            } else {
                LoginView(authService: authService)
            }
        }
        .confirmationDialog("Logged in as \(authService.username ?? "")", isPresented: $showingProfileOptions) {
            Button("Logout of account: \(authService.username ?? "")") {
                authService.logout()
            }
        }
    }
}

