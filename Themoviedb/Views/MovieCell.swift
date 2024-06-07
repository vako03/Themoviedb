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
        VStack(spacing: 8) {
            posterView
                .frame(width: 100, height: 145.92) // Fixed size for the poster
            titleView
                .frame(width: 100) // Limiting the width of text to 100px
        }
        .padding(8)
        .cornerRadius(16)
    }
    
    private var posterView: some View {
        Group {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .cornerRadius(16) // Adjusted corner radius
                } placeholder: {
                    Color.gray
                        .cornerRadius(16) // Adjusted corner radius
                }
            } else {
                Color.gray
                    .cornerRadius(16) // Adjusted corner radius
            }
        }
    }
    
    private var titleView: some View {
        Text(movie.title)
            .font(.system(size: 12))
            .lineLimit(2) // Limiting to 2 lines
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5) // Allow text to scale down if needed
            .padding(.horizontal, 8) // Adding horizontal padding to center the text
            .foregroundColor(Color(UIColor.label)) // Use system color for text
    }
}
