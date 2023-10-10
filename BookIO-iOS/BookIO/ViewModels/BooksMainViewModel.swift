//
//  BookListViewModel.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

enum BooksMainViewModelState {
    case loading
    case error
    case loaded([Book])
}

class BooksMainViewModel: ObservableObject {
    private let authService: AuthService
    private let bookService: BookService
    @Published var state: BooksMainViewModelState = .loading

    init(authService: AuthService, bookService: BookService = BookService()) {
        self.authService = authService
        self.bookService = bookService
    }
    
    @MainActor private func updateState(_ state: BooksMainViewModelState) {
        self.state = state
    }

    func refresh() {
        guard let username = authService.username else {
            return
        }

        Task {
            do {
                let books = try await bookService.fetchBookData(username: username)
                await updateState(.loaded(books))
            } catch {
                await updateState(.error)
            }
        }
    }

    func favoriteBookWithId(_ id: String) {
        guard let username = authService.username else {
            return
        }

        Task {
            try? await bookService.favoriteBookWithId(id, username: username)
        }
    }
}
