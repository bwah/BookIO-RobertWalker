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

#Preview {
    VStack {
        BookRowView(book: previewBooks()[0])
    }.padding()
}
