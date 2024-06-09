//
//  MainTabView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MoviesCollectionView()
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                        .foregroundColor(selection == 0 ? Color.blue : Color.gray)
                    Text("Home")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image("Search")
                        .renderingMode(.template)
                        .foregroundColor(selection == 1 ? Color.blue : Color.gray)
                    Text("Search")
                }
                .tag(1)
            
            FavoritesView()
                .tabItem {
                    Image("Save")
                        .renderingMode(.template)
                        .foregroundColor(selection == 2 ? Color.blue : Color.gray)
                    Text("Favorites")
                }
                .tag(2)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
