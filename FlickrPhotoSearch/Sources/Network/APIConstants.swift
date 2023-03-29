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
    static let apiKey = "249b7b1bb5210e975eb2827149a20161"

    static let flickrUserId = "66956608@N06"
    static let jsonFormat = "json"
    static let extras = "date_upload,owner_name,url_w"

    
    static let jsonNoCallback = 1
    static let photosPerPage = 100
}
