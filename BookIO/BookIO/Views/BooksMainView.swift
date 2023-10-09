//
//  BooksListView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BooksMainView: View {

    @ObservedObject var viewModel: BooksMainViewModel

    init(viewModel: BooksMainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .error:
                Text("Something went wrong, please try again...")
            case .loading:
                ProgressView()
            case .loaded(let books):
                listView(books: books)
            }
        }
        .onAppear {
            viewModel.refresh()
        }
    }

    private func listView(books: [Book]) -> some View {
        List(books) { book in
            NavigationLink {
                BookDetailView(book: book) { book in
                    viewModel.favoriteBookWithId(book.id)
                }
            } label: {
                BookRowView(book: book)
                    .padding(4)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refresh()
        }
    }
}
