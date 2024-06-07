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
                .padding(.bottom, 60)

                if let overview = movie.overview {
                    Text(overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                // Centering HStack horizontally with images
                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        
                        if let releaseDate = movie.releaseDate {
                            HStack {
                                Image("CalendarBlank")
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
                                Image("globus")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(originalLanguage)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
                .frame(height: 20) // Ensure the GeometryReader doesn't take unnecessary space
                .font(.caption)
                .foregroundColor(.secondary)
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

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movie(
            id: 1,
            title: "Sample Movie",
            posterPath: "poster1.jpg",
            backdropPath: "backdrop1.jpg",
            overview: "This is a sample overview of the movie.",
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
