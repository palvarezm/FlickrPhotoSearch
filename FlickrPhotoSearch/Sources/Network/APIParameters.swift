//
//  APIParameters.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

struct APIParameters {
    struct GetTrendingFeedParams: Encodable {
        var method: String = FlickrRequest.getPopular.method
        var apiKey: String = APIConstants.apiKey
        var userId: String = APIConstants.flickrUserId
        var format: String = "json"
        var noJsonCallback: Int = APIConstants.jsonNoCallback
        var page: Int = 0
        var perPage: Int = APIConstants.photosPerPage
        var extras: String = APIConstants.extras

        private enum CodingKeys: String, CodingKey {
            case method, format, page, extras
            case apiKey = "api_key"
            case userId = "user_id"
            case noJsonCallback = "nojsoncallback"
            case perPage = "per_page"
        }
    }

    struct GetSearchFeedParams: Encodable {
        var method: String = FlickrRequest.search.method
        var apiKey: String = APIConstants.apiKey
        var searchText: String = ""
        var format: String = "json"
        var noJsonCallback: Int = APIConstants.jsonNoCallback
        var page: Int = 0
        var perPage: Int = APIConstants.photosPerPage
        var extras: String = APIConstants.extras
        
        private enum CodingKeys: String, CodingKey {
            case method, format, page, extras
            case apiKey = "api_key"
            case searchText = "text"
            case noJsonCallback = "nojsoncallback"
            case perPage = "per_page"
        }
    }
}
