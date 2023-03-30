//
//  FeedCellViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 29/03/23.
//

import UIKit
import Combine

class FeedCellViewModel {
    enum Input {
        case cellWillAppear(url: URL)
    }

    enum Output {
        case updateImage(image: UIImage)
    }

    private let output = PassthroughSubject<FeedCellViewModel.Output, Never>()
    private var cancellables: Set<AnyCancellable> = Set()

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .cellWillAppear(let url):
                self?.getImage(for: url)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }

    func getImage(for url: URL) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.global())
         .sink { _ in }
        receiveValue: { [weak self] value in
            guard let image = UIImage(data: value.data) else { return }
            self?.output.send(.updateImage(image: image))
        }.store(in: &cancellables)
    }
}
