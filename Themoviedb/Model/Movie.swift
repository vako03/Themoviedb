//
//  Movie.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String? // Add backdrop_path property
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let runtime: Int?
    let language: String? // Add language property
    let popularity: Double? // Add popularity property
    let voteCount: Int? // Add vote_count property
    let originalLanguage: String? // Add original_language property
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path" // Map to the correct JSON key
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case language // Add language case
        case popularity // Add popularity case
        case voteCount = "vote_count" // Map to the correct JSON key
        case originalLanguage = "original_language" // Map to the correct JSON key
    }
    
    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
    
    var backdropURL: URL? {
        if let backdropPath = backdropPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
        }
        return nil
    }
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
