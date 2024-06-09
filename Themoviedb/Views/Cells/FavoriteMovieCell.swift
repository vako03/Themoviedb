//
//  FavoriteMovieCell.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 09.06.24.
//

import SwiftUI

struct FavoriteMovieCell: View {
    let movie: Movie // Assuming you have a Movie model
    
    var body: some View {
        // Custom view for displaying a favorite movie
        // You can design this based on your requirements
        Text(movie.title)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
