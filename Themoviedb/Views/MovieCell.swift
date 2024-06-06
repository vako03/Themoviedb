//
//  MovieCell.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import SwiftUI

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8)
        {
            posterView
            detailsView
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
    
    private var posterView: some View {
        Group {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipped()
            } else {
                Color.gray
                    .frame(maxWidth: .infinity, maxHeight: 200)
            }
        }
    }
    
    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(movie.releaseDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text(String(format: "%.1f", movie.voteAverage))
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
