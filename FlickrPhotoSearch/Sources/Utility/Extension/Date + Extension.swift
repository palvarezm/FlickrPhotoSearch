//
//  Date + Extension.swift
//  FlickrPhotoSearch
//
//  Created by Paul Alvarez on 28/03/23.
//

import Foundation

extension Date {
    init(seconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds))
    }

    func formattedAsPhotoInfoString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: self)
    }
}
