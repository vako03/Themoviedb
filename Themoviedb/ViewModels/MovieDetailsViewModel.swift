//
//  MovieDetailsViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var genre: String?
    @Published var runtime: Int?
    
    func fetchMovieDetails(for movie: Movie) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=efd9612c65e2c9429f246e3cb4325002") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching movie details: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(MovieDetails.self, from: data) {
                DispatchQueue.main.async {
                    // Extract genre
                    if let genres = decodedResponse.genres, let firstGenre = genres.first {
                        self.genre = firstGenre.name
                    }
                    
                    // Set runtime
                    self.runtime = decodedResponse.runtime
                }
            }
        }.resume()
    }
}
