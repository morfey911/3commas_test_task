//
//  DetailsSceneRouter.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol DetailsSceneRoutingLogic {}

protocol DetailsSceneDataPassing {
    var dataStore: DetailsSceneDataStore? { get }
}

final class DetailsSceneRouter: DetailsSceneRoutingLogic, DetailsSceneDataPassing {
    weak var viewController: UIViewController?
    var dataStore: DetailsSceneDataStore?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}
