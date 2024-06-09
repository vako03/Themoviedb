//
//  MoviesCollectionView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//
import SwiftUI

struct MoviesCollectionView: View {
    @StateObject private var viewModel = MoviesViewModel()
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCell(movie: movie)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
        }
    }
}
