//
//  BookRowView.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import SwiftUI

struct BookRowView: View {
    let book: Book

    init(book: Book) {
        self.book = book
    }

    var body: some View {
        HStack(alignment: .center) {

            VStack(alignment: .leading) {

                Text(book.title)
                    .font(.headline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                Text(book.author)
                    .font(.callout)
            }

            Spacer()

            if book.favorite {
                FavoriteCalloutView()
            }

        }
    }
}

struct FavoriteCalloutView: View {
    var body: some View {
        Text("FAVORITE")
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .font(.caption2)
            .foregroundStyle(.white)
            .background(.yellow)
            .clipShape(Capsule())
    }
}
