//
//  NetworkManager.swift
//  Themoviedb
//
//  Created by valeri mekhashishvili on 05.06.24.
//

import Foundation
import Combine

class NetworkManager<T: Decodable>: ObservableObject {
    @Published var result: Result<T, Error>?
    var cancellables = Set<AnyCancellable>()
    
    func fetch(url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
                if (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) != nil {
                }
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .map { Result.success($0) }
            .catch { Just(Result.failure($0)) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.result = $0 }
            .store(in: &cancellables)
    }
}
