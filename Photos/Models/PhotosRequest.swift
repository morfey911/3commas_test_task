//
//  PhotosRequest.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

struct PhotosRequest: DataRequest {
    var url: String {
        "https://api.flickr.com/services/rest/"
    }
    
    let queryItems: [String : String]
    
    var method: HTTPMethod {
        .get
    }
    
    init(apiKey: String, page: Int, perPage: Int) {
        self.queryItems = [
            "api_key": apiKey,
            "method": "flickr.interestingness.getList",
            "format": "json",
            "nojsoncallback": "1",
            "extras": "url_m",
            "page": "\(page)",
            "per_page": "\(perPage)"
        ]
    }
    
    func decode(_ data: Data) throws -> PhotosResponse {
        let result = try JSONDecoder().decode(FlickrAPIResponse.self, from: data)
        return result.photos
    }
}
