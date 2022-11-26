//
//  DetailsSceneInteractor.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol DetailsSceneDataStore {
    var title: String? { get set }
    var photo: UIImage? { get set }
}

protocol DetailsSceneBusinessLogic {
    var title: String? { get }
    var photo: UIImage? { get }
}

final class DetailsSceneInteractor: DetailsSceneDataStore, DetailsSceneBusinessLogic {
    var presenter: DetailsScenePresentationLogic?
    
    var title: String?
    var photo: UIImage?
}
