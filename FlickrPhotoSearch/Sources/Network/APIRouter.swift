//
//  APIRouter.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

class APIRouter {
    struct GetTrendingFeed: Request {
        typealias ReturnType = FlickrPhotosGetPopularResponse
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?

        init(queryParams: APIParameters.GetTrendingFeedParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
