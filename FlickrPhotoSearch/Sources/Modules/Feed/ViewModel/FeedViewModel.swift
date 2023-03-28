//
//  FeedViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Combine

class FeedViewModel {
    private var cancellables: Set<AnyCancellable> = []

    func getFeed() {
        #warning("Implement TODO")
        // TODO: Add page to GetFeedParams(page: page) and handle if .isEmpty
        APIClient.dispatch(
            APIRouter.GetFeed(queryParams: APIParameters.GetFeedParams()))
            .sink { _ in }
            receiveValue: { [weak self] data in
                let fetchedPhotos = data.photos.photo
                var index = 0
                fetchedPhotos.forEach { photo in
                    index += 1
                    print("****\(index)****")
                    print(photo)
                }
            }
            .store(in: &cancellables)
    }
}
