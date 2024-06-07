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
    @Environment(\.colorScheme) var colorScheme // Access color scheme
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
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10) // Adjust the padding as needed
                                    .foregroundColor(colorScheme == .dark ? .white : .black) // Set the tint color based on color scheme
                            }
                            .padding(.trailing, 10)
                        )
                    
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
                
                if viewModel.query.isEmpty {
                    VStack {
                        Text("Use The Magic Search!")
                            .font(.system(size: 16))
                            .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on color scheme
                            .padding(.bottom, 4)
                        
                        Text("I will do my best to search everything\nrelevant, I promise!")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#92929D")) // Apply custom color
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    if viewModel.movies.isEmpty {
                        VStack {
                            Text("Oh No Isn’t This So \nEmbarrassing?")
                                .font(.system(size: 16))
                                .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on color scheme
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 4)
                            
                            Text("I cannot find any movie with this name.")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#92929D")) // Apply custom color
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // Vertical scrollable grid for movies
                        ScrollView {
                            LazyVStack(spacing: 24) {
                                ForEach(viewModel.movies) { movie in
                                    SearchMovieCell(movie: movie)
                                        .frame(width: 307, height: 120) // Set the width and height of each cell
                                }
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Search")
            .padding(.bottom)
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
