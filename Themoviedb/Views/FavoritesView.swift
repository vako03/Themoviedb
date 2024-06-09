//
//  FavoritesView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI
struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteMovies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        FavoriteMovieCell(movie: movie)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}


struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("No favourites yet")
                .font(.title)
                .foregroundColor(.gray)
            
            Text("All movies marked as favourite will be added here.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hex: "#92929D"))
                .padding(.horizontal)
        }
        .padding(.top, 50) // Adjust top padding as needed
    }
}

