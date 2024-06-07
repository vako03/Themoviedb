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
    @State private var isButtonClicked = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar and options
                HStack {
                    TextField("Search for a movie", text: $viewModel.query)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(8)
                    
                    Button(action: {
                        viewModel.isShowingOptions.toggle()
                        isButtonClicked.toggle()
                    }) {
                        Image("ellipsis")
                            .renderingMode(.template) // Set rendering mode to adjust tint color
                            .foregroundColor(isButtonClicked ? Color.gray : Color.primary) // Use system colors for better compatibility
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                if viewModel.isShowingOptions {
                    VStack {
                        ForEach(SearchOption.allCases, id: \.self) { option in
                            Button(action: {
                                viewModel.selectedOption = option
                                viewModel.isShowingOptions.toggle()
                                isButtonClicked = false // Reset the button state
                            }) {
                                HStack {
                                    Text(option.description)
                                    Spacer()
                                    if viewModel.selectedOption == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                            .foregroundColor(.primary)
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                // Vertical scrollable grid for movies
                ScrollView(.vertical) {
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.movies) { movie in
                            SearchMovieCell(movie: movie)
                                .frame(width: 307, height: 120) // Set the width and height of each cell
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Search")
        }
    }
}

enum SearchOption: String, CaseIterable, Identifiable {
    case name
    case genre
    case releaseYear
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .genre:
            return "Genre"
        case .releaseYear:
            return "Release Year"
        }
    }
}
