//
//  MoviesCollectionView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//
import SwiftUI

struct MoviesCollectionView: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    @State private var currentPage = 1
    @State private var selectedPage: Int? = 1
    
    var body: some View {
        NavigationView {
            VStack {
                movieList
                pageSelectionButtons
            }
            .onAppear {
                viewModel.fetchMovies(page: currentPage)
            }
            .navigationTitle("Movie List")
        }
    }
    
    private var movieList: some View {
        ScrollView {
            ForEach(viewModel.movies) { movie in
                MovieCell(movie: movie)
            }
        }
    }
    
    private var pageSelectionButtons: some View {
        HStack {
            ForEach(1...5, id: \.self) { page in
                Button("\(page)") {
                    currentPage = page
                    viewModel.fetchMovies(page: page)
                    selectedPage = page
                }
                .padding()
                .background(selectedPage == page ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
        }
    }
}
