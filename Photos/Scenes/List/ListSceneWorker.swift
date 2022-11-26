//
//  ListSceneWorker.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

protocol ListSceneFetchLogic {
    func makeLoadRequest(
        apiKey: String,
        page: Int,
        pageLimit: Int,
        completion: @escaping (Result<PhotosResponse, Error>) -> Void
    )
}

final class ListSceneWorker {
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
}

extension ListSceneWorker: ListSceneFetchLogic {
    func makeLoadRequest(
        apiKey: String,
        page: Int,
        pageLimit: Int,
        completion: @escaping (Result<PhotosResponse, Error>) -> Void)
    {
        let request = PhotosRequest(apiKey: apiKey, page: page, perPage: pageLimit)
        self.service.request(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
