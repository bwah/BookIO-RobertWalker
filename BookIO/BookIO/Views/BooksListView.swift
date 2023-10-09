//
//  BooksListView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BooksListView: View {
    private var books: [Book]
    private var refreshAction: () -> Void

    init(books: [Book], refreshAction: @escaping () -> Void) {
        self.books = books
        self.refreshAction = refreshAction
    }

    var body: some View {
        List(books) { book in
            NavigationLink {
                BookDetailView(book: book) { book in
                    print("asdf")
                }
            } label: {
                BookRowView(book: book)
                    .padding(4)
            }
        }
        .listStyle(.plain)
        .refreshable {
            refreshAction()
        }
    }
}
