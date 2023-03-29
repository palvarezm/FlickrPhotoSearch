//
//  APIRouter.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

struct APIRouter {
    struct GetTrendingFeed: Request {
        typealias ReturnType = FlickrPhotosResponse
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?

        init(queryParams: APIParameters.GetTrendingFeedParams) {
            self.queryParams = queryParams.asDictionary
        }
    }

    struct GetSearchFeed: Request {
        typealias ReturnType = FlickrPhotosResponse
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        
        init(queryParams: APIParameters.GetSearchFeedParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
