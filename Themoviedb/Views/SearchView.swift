//
//  SearchView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ScaledMetric var cellFontSize: CGFloat = 16
    
    var body: some View {
        NavigationView {
            VStack {
                movieScrollView
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.query, prompt: "Search for a movie")
        }
    }
    
    private var movieScrollView: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns(), spacing: 10) {
                ForEach(viewModel.movies) { movie in
                    MovieCell(movie: movie)
                        .font(.system(size: cellFontSize))
                        .frame(width: gridSize(), height: 250)
                }
            }
            .padding()
        }
    }
    
    private func gridColumns() -> [GridItem] {
        if horizontalSizeClass == .compact {
            return [
                GridItem(.adaptive(minimum: gridSize()))
            ]
        } else {
            return [
                GridItem(.adaptive(minimum: gridSize())),
                GridItem(.adaptive(minimum: gridSize()))
            ]
        }
    }
    
    private func gridSize() -> CGFloat {
        if horizontalSizeClass == .compact {
            return UIScreen.main.bounds.width - 30
        } else {
            return (UIScreen.main.bounds.width - 50) / 2
        }
    }
}
