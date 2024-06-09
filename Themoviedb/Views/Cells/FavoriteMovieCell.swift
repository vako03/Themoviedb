//
//  FavoriteMovieCell.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI

struct FavoriteMovieCell: View {
    let movie: Movie
    @StateObject private var viewModel = MovieDetailsViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    case .failure:
                        Color.red
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    @unknown default:
                        Color.blue
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    }
                }
            } else {
                Color.gray
                    .frame(width: 95, height: 120)
                    .cornerRadius(16)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer(minLength: 4)
                
                if let voteAverage = movie.voteAverage {
                    HStack {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color(hex: "#FF8700"))
                        Text("\(String(format: "%.1f", voteAverage))")
                            .font(.system(size: 10))
                            .foregroundColor(Color(hex: "#FF8700"))
                    }
                } else {
                    Text("Vote Average: N/A")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                
                if let genre = viewModel.genre {
                    HStack {
                        Image("Ticket")
                        Text("\(genre)")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                
                if let releaseDate = movie.releaseDate {
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.secondary)
                        Text("\(releaseDate.year)")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                
                if let runtime = viewModel.runtime {
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.secondary)
                        Text("Runtime: \(runtime) mins")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("Runtime: N/A")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
        }
        .padding(.horizontal, 8)
        .cornerRadius(8)
        .onAppear {
            viewModel.fetchMovieDetails(for: movie)
        }
    }
}

