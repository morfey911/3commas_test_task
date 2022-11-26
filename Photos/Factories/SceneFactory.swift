//
//  SceneFactory.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol SceneFactory {
    func makeListScene() -> UIViewController
    func makeDetailsScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    func makeListScene() -> UIViewController {
        return ListSceneViewController()
    }
    
    func makeDetailsScene() -> UIViewController {
        return DetailsSceneViewController()
    }
}
