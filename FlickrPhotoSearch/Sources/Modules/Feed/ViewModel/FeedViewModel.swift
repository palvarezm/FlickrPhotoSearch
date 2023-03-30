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
        case viewShowSearchResults(searchText: String)
    }

    enum Output {
        case updateList(searchText: String? = nil)
    }

    var photoList = [FlickrPhotoModel]()

    private var apiClient: APIClient
    private let output = PassthroughSubject<FeedViewModel.Output, Never>()
    private var cancellables: Set<AnyCancellable> = []

    init(apiClient: APIClient = APIClientImpl()) {
        self.apiClient = apiClient
    }

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.getTrendingFeed()
            case .viewShowSearchResults(let searchText):
                self?.getSearchFeed(searchText: searchText)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }

    private func getTrendingFeed() {
        apiClient.dispatch(
            APIRouter.GetTrendingFeed(queryParams:
                                APIParameters.GetTrendingFeedParams()))
        .sink { _ in }
        receiveValue: { [weak self] data in
            let fetchedPhotos = data.photos.photo
            let photos = fetchedPhotos.map { FlickrPhotoModel(from: $0) }
            self?.photoList = photos.filter { $0.imageURL != nil }
            self?.output.send(.updateList())
        }.store(in: &cancellables)
    }

    private func getSearchFeed(searchText: String) {
        apiClient.dispatch(
            APIRouter.GetSearchFeed(queryParams: APIParameters.GetSearchFeedParams(searchText: searchText)))
            .sink { _ in }
            receiveValue: { [weak self] data in
                let fetchedPhotos = data.photos.photo
                let photos = fetchedPhotos.map { FlickrPhotoModel(from: $0) }
                self?.photoList = photos.filter { $0.imageURL != nil }
                self?.output.send(.updateList(searchText: searchText))
            }.store(in: &cancellables)
    }
}
