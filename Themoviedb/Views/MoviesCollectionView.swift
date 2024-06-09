//
//  MoviesCollectionView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//
import SwiftUI

struct MoviesCollectionView: View {
    @StateObject private var viewModel = MoviesViewModel()
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 150))]
    let rows = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: rows, spacing: 10) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)) {
                            MovieCell(movie: movie)
                                .frame(maxWidth: .infinity) 
                        }
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
