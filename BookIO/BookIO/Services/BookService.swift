//
//  BookService.swift
//  BookIO
//
//  Created by Robert Walker on 10/6/23.
//

import Foundation

class BookService: Service {

    func fetchBookData(username: String) async throws -> [Book] {
        await setLoading(true)
        
        async let booksResponse = fetchAllBooks()
        async let favoriteBookIdResponse = fetchFavoriteBookId(username: username)

        let (books, favoriteBookId) = try await (booksResponse, favoriteBookIdResponse)

        await setLoading(false)

        return books
            .setFavoriteBookWithId(favoriteBookId)
            .sortByFavoriteAndAlpha()
    }

    func favoriteBookWithId(_ id: String, username: String) async throws {
        let url = try buildApiUrlFromPath("/users/\(username)/favorites")
        _ = try await jsonHttp.post(url: url, body: ["book": id])
    }

    private func fetchAllBooks() async throws -> [Book] {
        let url = try buildApiUrlFromPath("/books")
        let response = try await jsonHttp.get(url: url, type: BooksDataResponse.self)
        return response.books
    }

    private func fetchFavoriteBookId(username: String) async -> String? {
        do {
            let url = try buildApiUrlFromPath("/users/\(username)/favorites")
            let response = try await jsonHttp.get(url: url, type: FavoritesDataResponse.self)
            return response.book
        } catch {
            return nil
        }
    }

}

extension BookService {
    private struct BooksDataResponse: Decodable {
        let data: BooksList

        var books: [Book] {
            return data.books
        }
    }

    private struct BooksList: Decodable {
        let books: [Book]
    }

    private struct FavoritesDataResponse: Decodable {
        let data: FavoritesResponse

        var book: String {
            return data.favorites.book
        }
    }

    private struct FavoritesResponse: Decodable {
        let favorites: FavoriteBook
    }

    private struct FavoriteBook: Decodable {
        let book: String
    }
}

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

extension Book {
    func copyAsFavorite(_ favorite: Bool) -> Book {
        var copy = self
        copy.setFavorite(favorite)
        return copy
    }
}
