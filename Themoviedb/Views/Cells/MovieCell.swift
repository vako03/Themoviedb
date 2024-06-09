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
                .frame(width: 100, height: 145.92)
            titleView
                .frame(width: 100)
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
                        .cornerRadius(16)
                } placeholder: {
                    Color.gray
                        .cornerRadius(16)
                }
            } else {
                Color.gray
                    .cornerRadius(16)
            }
        }
    }
    
    private var titleView: some View {
        Text(movie.title)
            .font(.system(size: 12))
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .padding(.horizontal, 8)
            .foregroundColor(Color(UIColor.label)) 
    }
}
