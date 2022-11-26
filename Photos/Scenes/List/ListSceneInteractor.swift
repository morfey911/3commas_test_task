//
//  ListSceneInteractor.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

protocol ListSceneBusinessLogic {
    var photos: [PhotoProtocol] { get }
    var morePhotosLeft: Bool { get }
    
    func loadPhotos()
}

final class ListSceneInteractor {
    var page: Int = 0
    var total: Int = 0
    var photos: [PhotoProtocol] = []
    
    var presenter: ListScenePresentationLogic?
    var worker: ListSceneFetchLogic?
}

extension ListSceneInteractor: ListSceneBusinessLogic {
    var morePhotosLeft: Bool {
        self.total > photos.count
    }
    
    func loadPhotos() {
        self.worker?.makeLoadRequest(
            apiKey: Constants.flickrKey,
            page: self.page + 1,
            pageLimit: Constants.pageLimit
        ) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let photoResponse):
                    guard let self = self else { return }
                    
                    self.page = photoResponse.page
                    self.total = photoResponse.total
                    self.photos.append(contentsOf: photoResponse.photos)
                    
                    self.presenter?.presentResult(response: ListScene.PerformFetch.Response(photos: self.photos))
                case .failure(let error):
                    self?.presenter?.presentError(error: error.localizedDescription)
                }
            }
        }
    }
}
