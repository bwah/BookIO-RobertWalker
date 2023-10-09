//
//  Book.swift
//  BookIO
//
//  Created by Robert Walker on 10/6/23.
//

import Foundation

struct Book: Decodable, Identifiable {
    let id: String
    let title: String
    let author: String
    let description: String
    let coverUrlString: String
    var favorite: Bool = false

    var coverUrl: URL? {
        return URL(string: coverUrlString)
    }

    mutating func setFavorite(_ favorite: Bool) {
        self.favorite = favorite
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case description
        case coverUrlString = "cover_url"
    }
}
