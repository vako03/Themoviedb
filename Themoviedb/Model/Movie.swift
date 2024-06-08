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
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let runtime: Int?
    let language: String?
    let popularity: Double?
    let voteCount: Int?
    let originalLanguage: String? 
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case language
        case popularity
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
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
