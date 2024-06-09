//
//  ContentView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.showSplash {
                SplashScreenView()
            } else {
                MainTabView()
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(UIDevice.current.userInterfaceIdiom == .pad)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
