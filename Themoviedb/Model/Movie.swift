//
//  Movie.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
}


struct MoviesResponse: Decodable {
    let results: [Movie]
}
