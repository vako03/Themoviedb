//
//  MainTabView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//

import SwiftUI


struct MainTabView: View {
    var body: some View {
        TabView {
            MoviesCollectionView()
                .tabItem {
                    Label("Home", image: "Home")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", image: "Search")
                }
        }
        .appBackground() // Apply background here
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
