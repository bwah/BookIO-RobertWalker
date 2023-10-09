//
//  Extensions.swift
//  BookIO
//
//  Created by Robert Walker on 10/8/23.
//

import Foundation

extension Array where Element == Book {
    func setFavoriteBookWithId(_ id: String?) -> [Book] {
        return self.map { book in
            return book.copyAsFavorite(book.id == id ?? "")
        }
    }

    func sortByFavoriteAndAlpha() -> [Book] {
        return self.sorted { a, b in
            if a.favorite {
                return true
            }

            if b.favorite {
                return false
            }

            return a.title < b.title
        }
    }
}
