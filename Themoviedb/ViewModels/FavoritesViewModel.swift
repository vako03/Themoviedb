//
//  FavoritesViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI
import Combine

class FavoritesViewModel: ObservableObject {
    static let shared = FavoritesViewModel()
    @Published var favoriteMovies: [Movie] = []

    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favoriteMovies"),
           let movies = try? JSONDecoder().decode([Movie].self, from: data) {
            self.favoriteMovies = movies
        }
    }
    
    func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteMovies) {
            UserDefaults.standard.set(data, forKey: "favoriteMovies")
        }
    }
    
    func addToFavorites(_ movie: Movie) {
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
            saveFavorites()
        }
    }
    
    func removeFromFavorites(_ movie: Movie) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: index)
            saveFavorites()
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favoriteMovies.contains(where: { $0.id == movie.id })
    }
}
