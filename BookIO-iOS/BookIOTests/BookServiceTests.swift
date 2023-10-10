//
//  BookServiceTests.swift
//  BookIOTests
//
//  Created by Robert Walker on 10/9/23.
//

import XCTest
@testable import BookIO

final class BookServiceTests: XCTestCase {
    var mockHttp: MockJsonHttp!
    let mockKeychainHelper = MockKeychainHelper()
    let testCredentials = Credentials(username: "user", password: "pass")
    var authService: AuthService!

    override func setUpWithError() throws {
        mockHttp = MockJsonHttp()
        authService = AuthService(jsonHttp: mockHttp, keychainHelper: mockKeychainHelper)
    }

    func testFetchBookData() throws {
        let bookService = BookService(jsonHttp: mockHttp)
        mockHttp.urlToReturnObjectMap["http://localhost:9000/books"] = BookService.mockBooksData()
        mockHttp.urlToReturnObjectMap["http://localhost:9000/users/user/favorites"] = BookService.mockFavoritesData()

        let booksExpectation = XCTestExpectation(description: "get method should return books array")

        Task {
            let books = try await bookService.fetchBookData(username: "user")
            booksExpectation.fulfill()
            XCTAssert(books.count == 3, "should return 3 books")
            XCTAssert(books[0].favorite, "favorite book should be sorted first")
            XCTAssert(books[1].title < books[2].title, "non-favorite books should be alpha sort")
        }

        wait(for: [booksExpectation], timeout: 1)
    }

    func testFavoriteBookRequest() {
        let bookService = BookService(jsonHttp: mockHttp)

        let favoriteExpectation = XCTestExpectation(description: "should post to fave url")

        Task {
            try await bookService.favoriteBookWithId("1", username: "user")
            let expectedUrlString = "http://localhost:9000/users/user/favorites"
            if mockHttp.requestedUrlSet.contains(expectedUrlString) {
                favoriteExpectation.fulfill()
            }
        }

        wait(for: [favoriteExpectation], timeout: 1)
    }
}
