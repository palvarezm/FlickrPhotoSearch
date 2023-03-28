//
//  APIConstants.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

final class APIConstants {
    static let baseURL = "https://www.flickr.com/services/rest"
    #warning("Remove apiKey")
    static let apiKey = "b7380e8136f191120be2ab19e058cc23"

    static let flickrUserId = "66956608@N06"
    static let jsonFormat = "json"
    static let extras = "date_upload,owner_name,url_w"

    
    static let jsonNoCallback = 1
    static let photosPerPage = 100
}
