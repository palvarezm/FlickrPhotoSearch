//
//  APIConstants.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

final class APIConstants {
    static let baseURL = "https://www.flickr.com/services/rest"
    #warning("api key should be handled at deployment")
    static let apiKey = "141349cc8aa80cc70f8cea4485e81095"

    static let flickrUserId = "66956608@N06"
    static let jsonFormat = "json"
    static let extras = "date_upload,owner_name,url_w"

    
    static let jsonNoCallback = 1
    static let photosPerPage = 300
}
