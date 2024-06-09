//
//  FavoriteMovieCell.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI

struct FavoriteMovieCell: View {
    let movie: Movie
    
    var body: some View {
        // Display favorite movie details
        Text(movie.title)
    }
}
