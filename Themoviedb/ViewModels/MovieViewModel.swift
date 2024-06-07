//
//  MovieViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import SwiftUI
import Combine

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private let networkManager = NetworkManager<MoviesResponse>()
    
    init() {
        fetchMovies()
        
        networkManager.$result
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    print("Error fetching movies: \(error.localizedDescription)")
                case .none:
                    break
                }
            }
            .store(in: &networkManager.cancellables)
    }
    
    func fetchMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=efd9612c65e2c9429f246e3cb4325002") else {
            return
        }
        networkManager.fetch(url: url)
    }
}
