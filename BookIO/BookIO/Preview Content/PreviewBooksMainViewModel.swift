//
//  PreviewBooksMainViewModel.swift
//  BookIO
//
//  Created by Robert Walker on 10/9/23.
//

import SwiftUI

func previewBooks() -> [Book] {
    return [
        Book(id: "1", title: "Book One", author: "Author One", description: "Description of book one", coverUrlString: "https://cdn.book.io/app/parlamint/67e55044-10b1-426f-9247-bb680e5fe0c8/cover.jpg"),
        Book(id: "2", title: "Book Two", author: "Author Two", description: "Description of book Two", coverUrlString: "https://cdn.book.io/app/parlamint/67e55044-10b1-426f-9247-bb680e5fe0c8/cover.jpg", favorite: true),
        Book(id: "3", title: "Book Three", author: "Author Three", description: "Description of book Three", coverUrlString: "https://cdn.book.io/app/parlamint/67e55044-10b1-426f-9247-bb680e5fe0c8/cover.jpg")
    ]
}

class PreviewBooksMainViewModel: BooksMainViewModel {
    init() {
        super.init(authService: AuthService(), bookService: BookService())

        self.state = .loaded(previewBooks())
    }
}
