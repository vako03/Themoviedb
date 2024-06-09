//
//  SearchViewModel.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var movies: [Movie] = []
    @Published var selectedOption: SearchOption = .name
    @Published var isShowingOptions: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager<MoviesResponse>()
    
    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func searchMovies(query: String) {
        guard !query.isEmpty else {
            self.movies = []
            return
        }
        
        var urlString = "https://api.themoviedb.org/3/search/movie?api_key=efd9612c65e2c9429f246e3cb4325002&query=\(query)"
        
        switch selectedOption {
        case .name:
            urlString += "&searchBy=name"
        case .genre:
            urlString += "&searchBy=genre"
        case .releaseYear:
            // If the selected option is release year, perform search by release year
            guard let year = Int(query) else {
                // If the query is not a valid year, return empty result
                self.movies = []
                return
            }
            urlString += "&searchBy=release_year&year=\(year)"
        }
        
        guard let encodedQuery = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedQuery) else {
            return
        }
        
        networkManager.fetch(url: url)
        
        networkManager.$result
            .sink { [weak self] result in
                switch result {
                case .success(let response):
                    self?.movies = response.results
                case .failure(let error):
                    print("Error searching movies: \(error.localizedDescription)")
                case .none:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
