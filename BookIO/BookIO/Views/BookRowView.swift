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
                    .font(.title3)
                    .fontWeight(.bold)
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))

                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
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
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .background(.yellow)
            .clipShape(Capsule())
    }
}
