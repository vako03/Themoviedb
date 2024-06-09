//
//  FavoritesView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteMovies.isEmpty {
                    VStack {
                        Text("No favorites yet")
                            .font(.system(size: 16))
                            .padding(.bottom, 4)
                        Text("All movies marked as favorite will be\n added here.")
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Display favorite movies here
                    Text("List of favorite movies")
                }
            }
            .navigationTitle("Favorites")
            .foregroundColor(.primary) // Ensure text color remains unchanged
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

