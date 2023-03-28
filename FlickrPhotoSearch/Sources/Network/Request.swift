//
//  Request.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Request {
    var method: HTTPMethod { get }
    var queryParams: [String: Any]? { get }
    associatedtype ReturnType: Codable
}

extension Request {
    var method: HTTPMethod { return .get }
    var queryParams: [String: Any]? { return nil }

    func addQueryParams(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else { return nil }

        return queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }

    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }

        urlComponents.path = "\(urlComponents.path)"
        urlComponents.queryItems = addQueryParams(queryParams: queryParams)

        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        return request
    }
}

enum FlickrRequest {
    case getPopular

    var method: String {
        switch self {
        case .getPopular: return "flickr.photos.getPopular"
        }
    }
}
