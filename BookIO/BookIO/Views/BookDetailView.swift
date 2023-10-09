//
//  BookDetailView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BookDetailView: View {
    @State private var book: Book
    private let favoriteAction: (Book) -> Void

    init(book: Book, favoriteAction: @escaping (Book) -> Void) {
        self.book = book
        self.favoriteAction = favoriteAction
    }

    var body: some View {
        VStack {
            if let imageUrl = book.coverUrl {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 250)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 30))
            }

            BookRowView(book: book)
                .padding(.bottom)

            Text(book.description)
                .font(.caption)
                .multilineTextAlignment(.leading)

            Spacer()

            if book.favorite == false {
                BorderedButton(title: "Make Favorite") {
                    book.setFavorite(true)
                    favoriteAction(book)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 50, trailing: 30))
    }
}
