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
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=efd9612c65e2c9429f246e3cb4325002&query=\(encodedQuery)") else {
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
