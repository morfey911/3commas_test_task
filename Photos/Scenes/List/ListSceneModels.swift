//
//  ListModels.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

enum ListScene {
    struct Pagination {
        var page: Int
        var limit: Int
    }
    
    enum PerformFetch {
        struct Request {
            var apiKey: String
            var pagination: Pagination
        }
        struct Response {
            var photos: [PhotoProtocol]
        }
        struct ViewModel {
            var photos: [PhotoProtocol]
        }
    }
}
