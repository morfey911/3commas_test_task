//
//  PhotosResult.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

struct FlickrAPIResponse: Decodable {
    let photos: PhotosResponse
}

struct PhotosResponse: Decodable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: Int

    let photos: [Photo]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case total
        case perPage = "perpage"
        case photos = "photo"
    }
}
