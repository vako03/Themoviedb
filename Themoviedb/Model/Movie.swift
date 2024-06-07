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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
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

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
