//
//  Photo.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol PhotoProtocol {
    var url: String { get }
    var height: Int { get }
    var width: Int { get }
    var title: String { get }
}

struct Photo: PhotoProtocol, Decodable {
    let url: String
    let height: Int
    let width: Int
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case url = "url_m"
        case height = "height_m"
        case width = "width_m"
    }
}
