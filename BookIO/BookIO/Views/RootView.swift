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
        .confirmationDialog("Profile Options", isPresented: $showingProfileOptions) {
            Button("Logout") {
                authService.logout()
            }
        }
//        .fullScreenCover(isPresented: $authService.needsLogin) {
//            LoginView(authService: authService)
//        }
    }
}

