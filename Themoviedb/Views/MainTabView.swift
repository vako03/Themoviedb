//
//  MainTabView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//

import SwiftUI


import SwiftUI

struct MainTabView: View {
    @State private var selection = 0 // State to track selected tab
    
    var body: some View {
        TabView(selection: $selection) {
            MoviesCollectionView()
                .tabItem {
                    Image("Home") // Use your custom image from the asset catalog
                        .renderingMode(.template) // Use renderingMode to allow color changes
                        .foregroundColor(selection == 0 ? Color.blue : Color.gray) // Change color based on selection
                    Text("Home")
                }
                .tag(0) // Tag this view with index 0
            
            SearchView()
                .tabItem {
                    Image("Search") // Use your custom image from the asset catalog
                        .renderingMode(.template) // Use renderingMode to allow color changes
                        .foregroundColor(selection == 1 ? Color.blue : Color.gray) // Change color based on selection
                    Text("Search")
                }
                .tag(1) // Tag this view with index 1
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
