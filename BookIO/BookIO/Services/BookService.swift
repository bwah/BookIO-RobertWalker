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

    static func mockBooksData() -> BooksDataResponse {
        return BooksDataResponse(data: BooksList(books: previewBooks()))
    }

    static func mockFavoritesData() -> FavoritesDataResponse {
        return FavoritesDataResponse(data:
                                        FavoritesResponse(favorites:
                                                            FavoriteBook(book: "3")))
    }
}

extension BookService {
    struct BooksDataResponse: Decodable {
        let data: BooksList

        var books: [Book] {
            return data.books
        }
    }

    struct BooksList: Decodable {
        let books: [Book]
    }

    struct FavoritesDataResponse: Decodable {
        let data: FavoritesResponse

        var book: String {
            return data.favorites.book
        }
    }

    struct FavoritesResponse: Decodable {
        let favorites: FavoriteBook
    }

    struct FavoriteBook: Decodable {
        let book: String
    }
}
