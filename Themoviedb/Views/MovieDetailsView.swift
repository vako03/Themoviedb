//
//  MovieDetailsView.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 07.06.24.
//
import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @State private var screenWidth: CGFloat = 0
    @Environment(\.colorScheme) var colorScheme // Access color scheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    coverImageView
                        .frame(height: 210.94)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])

                    movieImageView
                        .frame(width: 95, height: 120)
                        .offset(x: 16, y: 60)

                    Text(movie.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(UIColor.label))
                        .multilineTextAlignment(.leading)
                        .frame(width: 210, height: 50)
                        .offset(x: 110, y: 60)
                }
                .padding(.bottom, 70)

                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        if let releaseDate = movie.releaseDate {
                            HStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("\(releaseDate.year) |")
                            }
                        }

                        if let voteCount = movie.voteCount {
                            HStack {
                                Image("tick")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("\(voteCount) |")
                            }
                        }

                        if let originalLanguage = movie.originalLanguage {
                            HStack {
                                Image(systemName: "globe")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(originalLanguage)
                            }
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width - 32) // Adjusted frame width to add space on both sides
                }
                .frame(height: 24) // Ensure the GeometryReader doesn't take unnecessary space
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16) // Added horizontal padding

                Text("About Movie")
                    .font(.system(size: 16))
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on color scheme
                    .padding(.horizontal, 16)

                Rectangle()
                    .frame(width: 327, height: 4)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 16)

                if let overview = movie.overview {
                    Text(overview)
                        .font(.body)
                        .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on color scheme
                        .padding(.horizontal, 16)
                }
            }
            .padding()
            .onAppear {
                screenWidth = UIScreen.main.bounds.width
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.clear)
    }



    private var coverImageView: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let backdropURL = movie.backdropURL {
                    AsyncImage(url: backdropURL) { phase in
                        switch phase {
                        case .empty:
                            Color.gray
                                .frame(width: screenWidth, height: 210.94)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: screenWidth, height: 210.94)
                        case .failure:
                            Color.red
                                .frame(width: screenWidth, height: 210.94)
                        @unknown default:
                            Color.blue
                                .frame(width: screenWidth, height: 210.94)
                        }
                    }
                } else {
                    Color.gray
                        .frame(width: screenWidth, height: 210.94)
                }
            }
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])

            if let voteAverage = movie.voteAverage {
                HStack {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(hex: "#FF8700"))

                    Text(String(format: "%.1f", voteAverage))
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#FF8700"))
                        .bold()
                }
                .padding(8)
                .background(Color.black.opacity(0.7))
                .cornerRadius(8)
                .padding([.trailing, .bottom], 16)
            }
        }
    }

    private var movieImageView: some View {
        Group {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    case .failure:
                        Color.red
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    @unknown default:
                        Color.blue
                            .frame(width: 95, height: 120)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                }
            } else {
                Color.gray
                    .frame(width: 95, height: 120)
                    .cornerRadius(16)
                    .shadow(radius: 5)
            }
        }
    }
}

extension String {
    var year: String {
        let components = self.components(separatedBy: "-")
        if let year = components.first {
            return year
        }
        return ""
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8 * 17), (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16), (int >> 8 & 0xFF), (int & 0xFF))
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24), (int >> 16 & 0xFF), (int >> 8 & 0xFF), (int & 0xFF))
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movie(
            id: 1,
            title: "Sample Movie",
            posterPath: "poster1.jpg",
            backdropPath: "backdrop1.jpg",
            overview: "This is a sample overview of the movie. It should be a brief description of the movie plot.",
            releaseDate: "2023-01-01",
            voteAverage: 4.5,
            runtime: 120,
            language: "English",
            popularity: 8.7,
            voteCount: 1500,
            originalLanguage: "en"
        )

        MovieDetailsView(movie: sampleMovie)
            .preferredColorScheme(.light)
    }
}
