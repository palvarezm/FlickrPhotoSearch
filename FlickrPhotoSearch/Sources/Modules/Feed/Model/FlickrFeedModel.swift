//
//  FlickrFeedModel.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

struct FlickrPhotoModel: Decodable {
    var id: String
    var imageURL: String?
    var imageHeight: Int?
    var imageWidth: Int?
    var author: String
    var title: String
    var publishedAt: String

    init(from response: FlickrPhotoItemResponse) {
        self.id = response.id
        self.imageURL = response.imageURL
        self.author = response.ownerName
        self.title =  response.title
        self.publishedAt = Date(seconds: Int64(response.dateUpload) ?? 0).formattedAsPhotoInfoString()
        self.imageHeight = response.imageHeight
        self.imageWidth = response.imageWidth
    }
}
