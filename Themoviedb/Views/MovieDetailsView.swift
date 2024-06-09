//
//  MovieDetailsView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//
import SwiftUI

struct MovieDetailsView: View {
    @State var movie: Movie // Change to @State variable
    @State private var screenWidth: CGFloat = 0
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = MovieDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    coverImageView
                        .frame(height: 210.94)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                    
                    movieImageView
                        .frame(width: 95, height: 120)
                        .offset(x: 16, y: 60)
                    
                    Text(movie.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(UIColor.label))
                        .multilineTextAlignment(.leading)
                        .frame(width: 210, height: 50)
                        .offset(x: 110, y: 60)
                }
                .padding(.bottom, 70)
                
                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        if let releaseDate = movie.releaseDate {
                            HStack {
                                Image("CalendarBlank")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(" \(releaseDate.year) |")
                            }
                        }
                        
                        if let runtime = viewModel.runtime {
                            HStack {
                                Image(systemName:"clock")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("\(runtime) mins |")
                            }
                        }
                        Image("Ticket")
                        Text(" \(viewModel.genre ?? "") ")
                        
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width - 16)
                }
                .frame(height: 24)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                
                Text("About Movie")
                    .font(.system(size: 16))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.horizontal, 16)
                
                Rectangle()
                    .frame(width: 327, height: 4)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 16)
                
                if let overview = movie.overview {
                    Text(overview)
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.horizontal, 16)
                }
            }
            .padding()
            .onAppear {
                screenWidth = UIScreen.main.bounds.width
                viewModel.fetchMovieDetails(for: movie)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.clear)
    }
    
    
    private var coverImageView: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let backdropURL = movie.backdropURL {
                    AsyncImage(url: backdropURL) { phase in
                        switch phase {
                        case .empty:
                            Color.gray
                                .frame(width: screenWidth, height: 210.94)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: screenWidth, height: 210.94)
                        case .failure:
                            Color.red
                                .frame(width: screenWidth, height: 210.94)
                        @unknown default:
                            Color.blue
                                .frame(width: screenWidth, height: 210.94)
                        }
                    }
                } else {
                    Color.gray
                        .frame(width: screenWidth, height: 210.94)
                }
            }
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            
            if let voteAverage = movie.voteAverage {
                HStack {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#FF8700"))
                    
                    Text(String(format: "%.1f", voteAverage))
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#FF8700"))
                        .bold()
                }
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .padding([.trailing, .bottom], 16)
            }
        }
    }
    
    private var movieImageView: some View {
        Group {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    case .failure:
                        Color.red
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    @unknown default:
                        Color.blue
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                }
            } else {
                Color.gray
                    .frame(width: 95, height: 120)
                    .cornerRadius(16)
            }
        }
    }
    
}
