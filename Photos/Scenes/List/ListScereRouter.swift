//
//  ListScereRouter.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol ListSceneRoutingLogic {
    func routeToShowPhoto(image: UIImage, title: String)
    func routeToShowFailure(message: String)
}

final class ListSceneRouter {
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension ListSceneRouter: ListSceneRoutingLogic {
    func routeToShowPhoto(image: UIImage, title: String) {
        let scene = self.sceneFactory.makeDetailsScene() as! DetailsSceneViewController
        var destinationDS = scene.router!.dataStore!
        
        destinationDS.title = title
        destinationDS.photo = image
        
        self.source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func routeToShowFailure(message: String) {
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            alertViewController.dismiss(animated: true)
        }
        alertViewController.addAction(okAction)
        self.source?.present(alertViewController, animated: true)
    }
}
