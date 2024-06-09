//
//  FavoritesViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    static let shared = FavoritesViewModel()
    
    @Published var favoriteMovies: [Movie] = []
    
    func addToFavorites(_ movie: Movie) {
        if !favoriteMovies.contains(movie) {
            favoriteMovies.append(movie)
        }
    }
    
    func removeFromFavorites(_ movie: Movie) {
        if let index = favoriteMovies.firstIndex(of: movie) {
            favoriteMovies.remove(at: index)
        }
    }
}
