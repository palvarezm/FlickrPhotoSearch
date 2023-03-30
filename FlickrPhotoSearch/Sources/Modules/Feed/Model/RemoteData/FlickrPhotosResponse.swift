//
//  FlickrPhotosGetPopularResponse.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

struct FlickrPhotosResponse: Codable {
    var photos: Photos
    var stat: String

    struct Photos: Codable {
        var page: Int
        var pages: Int
        var perPage: Int
        var total: Int
        var photo: [FlickrPhotoItemResponse]

        private enum CodingKeys: String, CodingKey {
            case page, pages, total, photo
            case perPage = "perpage"
        }
    }
}

struct FlickrPhotoItemResponse: Identifiable, Codable {
    var id: String
    var ownerName: String
    var secretId: String
    var serverId: String
    var title: String
    var dateUpload: String
    var imageURL: String?
    var imageHeight: Int?
    var imageWidth: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, title
        case ownerName = "ownername"
        case secretId = "secret"
        case serverId = "server"
        case dateUpload = "dateupload"
        case imageURL = "url_w"
        case imageHeight = "height_w"
        case imageWidth = "width_w"
    }
}
