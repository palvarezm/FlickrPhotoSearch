//
//  FeedViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Combine

class FeedViewModel {
    enum Input {
        case viewDidLoad
    }

    enum Output {
        case updateList
    }

    var photoList = [FlickrPhotoModel]()

    private let output = PassthroughSubject<FeedViewModel.Output, Never>()
    private var cancellables: Set<AnyCancellable> = []

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.getTrendingFeed()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }

    private func getTrendingFeed() {
        APIClient.dispatch(
            APIRouter.GetTrendingFeed(queryParams:
                                APIParameters.GetTrendingFeedParams()))
        .sink { _ in }
        receiveValue: { [weak self] data in
            let fetchedPhotos = data.photos.photo
            self?.photoList.append(contentsOf: fetchedPhotos.map { FlickrPhotoModel(from: $0)} )
            self?.output.send(.updateList)
        }.store(in: &cancellables)
    }
}