//
//  ListScenePresenter.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import Foundation

protocol ListScenePresentationLogic {
    func presentResult(response: ListScene.PerformFetch.Response)
    func presentError(error: String)
}

final class ListScenePresenter {
    weak var viewController: ListSceneDisplayLogic?
}

extension ListScenePresenter: ListScenePresentationLogic {
    func presentResult(response: ListScene.PerformFetch.Response) {
        self.viewController?.displayResult(viewModel: ListScene.PerformFetch.ViewModel(photos: response.photos))
    }
    
    func presentError(error: String) {
        self.viewController?.displayError(error: error)
    }
}
