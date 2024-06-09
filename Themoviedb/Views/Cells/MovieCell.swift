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
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    case .success(let image):
                        image
                            .resizable()
                            .cornerRadius(16)
                    case .failure:
                        Color.gray
                            .cornerRadius(16)
                    @unknown default:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
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
            .multilineTextAlignment(.center)
            .lineLimit(2) // Limit to a maximum of two lines
            .padding(.horizontal, 8)
            .frame(width: 100)
            .foregroundColor(Color(UIColor.label))
    }



}
