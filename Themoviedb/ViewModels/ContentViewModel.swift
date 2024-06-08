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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showSplash = false
            }
        }
    }
}
