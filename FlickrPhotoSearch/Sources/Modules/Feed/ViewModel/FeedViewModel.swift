//
//  FeedViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Combine

enum PageStatus {
    case ready(nextPage: Int)
    case loading(page: Int)
    case done
}

class FeedViewModel {
    enum Input {
        case viewDidLoad
        case viewDidScrollToLast
    }

    enum Output {
        case updateList
    }

    var photoList = [FlickrPhotoModel]()

    var endOfList = false
    var pageStatus = PageStatus.ready(nextPage: 0)

    private let output = PassthroughSubject<FeedViewModel.Output, Never>()
    private var cancellables: Set<AnyCancellable> = []

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.getFeed()
            case .viewDidScrollToLast:
                self?.getFeed()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }

    func getFeed() {
        guard case let .ready(page) = pageStatus else { return }

        pageStatus = .loading(page: page)
        APIClient.dispatch(
            APIRouter.GetFeed(queryParams:
                                APIParameters.GetFeedParams(page: page)))
        .sink { _ in }
        receiveValue: { [weak self] data in
            let fetchedPhotos = data.photos.photo
            if fetchedPhotos.isEmpty {
                self?.endOfList = true
                self?.pageStatus = .done
            } else {
                self?.pageStatus = .ready(nextPage: page + 1)
                self?.photoList.append(contentsOf: fetchedPhotos.map { FlickrPhotoModel(from: $0)} )
                self?.output.send(.updateList)
            }
        }.store(in: &cancellables)
    }

    func shouldLoadMoreFeed(item: FlickrPhotoModel) -> Bool {
        return item.id == photoList.last?.id
    }
}
