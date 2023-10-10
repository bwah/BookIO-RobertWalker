//
//  BookTests.swift
//  BookIOTests
//
//  Created by Robert Walker on 10/9/23.
//

import XCTest
@testable import BookIO

final class BookTests: XCTestCase {

    let data = """
    [
        {
            "id": "67e55044-10b1-426f-9247-bb680e5fe0c8",
            "title": "Dr. Jekyll & Mr. Hyde",
            "author": "Robert Louis Stevenson",
            "description": "First published in 1886 by Robert Louis Stevenson, the book is a famous piece of English Literature and is considered to be a defining book of the gothic horror genre. The novella has had a lasting impact on culture, making the phrase \\"Jekyll and Hyde\\" used to describe people who are outwardly good, but hide dark secrets of their true nature.",
            "cover_url": "https://cdn.book.io/app/parlamint/67e55044-10b1-426f-9247-bb680e5fe0c8/cover.jpg"
        },
        {
            "id": "48510d68-73f8-4d18-91c9-9aa4ac4655df",
            "title": "The Wizard Tim",
            "author": "Tim Canada & Joseph Eleam",
            "description": "Tim the lazy, overweight wizard has his dream job. As the town wizard for a halfling town named Halfass, he never has to do anything except eat, nap and do absolutely nothing. However, he soon finds out that even the best posts don't last forever...",
            "cover_url": "https://cdn.book.io/app/parlamint/48510d68-73f8-4d18-91c9-9aa4ac4655df/cover.jpg"
        }
    ]
    """.data(using: .utf8)!

    func testDecodableAndCoverUrl() throws {
        let books = try JSONDecoder().decode([Book].self, from: data)
        XCTAssert(books.count == 2, "should be 2 books decoded")
        XCTAssert(books.first?.title == "Dr. Jekyll & Mr. Hyde", "title should decode correctly")
        XCTAssert(books.first?.coverUrl != nil, "cover url should be created from coverUrlString")
    }
}
