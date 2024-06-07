//
//  ContentViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var showSplash: Bool = true
    
    init() {
        // Delay for 3 seconds before hiding the splash screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showSplash = false
            }
        }
    }
}
