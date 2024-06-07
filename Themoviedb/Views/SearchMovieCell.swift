//
//  SearchMovieCell.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.

import SwiftUI

struct SearchMovieCell: View {
    let movie: Movie
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top) { // Align content to the top
                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    } placeholder: {
                        Color.gray
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                    }
                } else {
                    Color.gray
                        .frame(width: 95, height: 120)
                        .cornerRadius(16)
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.system(size: 12))
                        .lineLimit(2)
                        .padding(.top, 4)
                    
                    if let releaseDate = movie.releaseDate {
                        Text("Release Year: \(releaseDate.year)")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    
                    if let voteAverage = movie.voteAverage {
                        Text("Vote Average: \(String(format: "%.1f", voteAverage))")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    } else {
                        Text("Vote Average: N/A")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading) // Expand the VStack to the left
            }
            .frame(height: 120)
            .padding(8)
            .cornerRadius(8) // Remove background color and keep only corner radius
        }
    }
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
