//
//  Result.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
struct SearchResponse: Model {
    var search: [MovieResponse]?
    var totalResults: String?
    var response: String
    var error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

struct MovieResponse: Model {
    var title, year, rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var poster: String
    var ratings: [Rating]?
    var metascore, imdbRating, imdbVotes, imdbID: String?
    var type, totalSeasons, response, error: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case totalSeasons
        case response = "Response"
        case error = "Error"
    }
}

// MARK: - Rating
struct Rating: Codable {
    var source, value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
