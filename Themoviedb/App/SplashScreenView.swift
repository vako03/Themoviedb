//
//  SplashScreenView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            if let splashImage = UIImage(named: "SplashScreenImage") {
                Image(uiImage: splashImage)
                    .resizable()
                    .frame(width: 215, height: 215)
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Image not found")
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
