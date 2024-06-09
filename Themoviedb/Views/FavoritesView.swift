//
//  FavoritesView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI
struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel.shared
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteMovies.isEmpty {
                    EmptyFavoritesView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.favoriteMovies) { movie in
                                FavoriteMovieCell(movie: movie)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorites")
            .foregroundColor(.primary)
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

