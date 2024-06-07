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
            VStack {
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
                
                movieScrollView
            }
            .navigationTitle("Search")
            .padding(.bottom)
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
