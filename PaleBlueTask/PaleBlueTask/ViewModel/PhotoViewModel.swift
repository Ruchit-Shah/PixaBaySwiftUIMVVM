//
//  PhotoViewModel.swift
//  PaleBlueTask
//
//  Created by Shah Ruchit Bhadreshbhai on 04/10/24.
//

import Combine
import SwiftUI

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    private var currentPage = 1
    private var cancellable: AnyCancellable?

    let apiKey = "22577733-edb14e0d0f3f9c1a039c57e48"
    let baseURL = "https://pixabay.com/api/"

    init() {
        fetchPhotos()
    }

    func fetchPhotos() {
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)&q=football&image_type=photo&page=\(currentPage)&per_page=16") else { return }
        print( url)
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: PixabayResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.photos.append(contentsOf: response.hits)
                self?.currentPage += 1
            })
    }
}

struct PixabayResponse: Decodable {
    let hits: [Photo]
}
