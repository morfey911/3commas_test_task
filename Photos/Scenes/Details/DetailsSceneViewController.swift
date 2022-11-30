//
//  DetailsSceneViewController.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol DetailsSceneDisplayLogic: AnyObject {}

final class DetailsSceneViewController: UIViewController, DetailsSceneDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: DetailsSceneBusinessLogic?
    var router: (DetailsSceneRoutingLogic & DetailsSceneDataPassing)?
    
    lazy var containerView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        
        [self.imageView,
         self.titleLabel].forEach {
            view.addArrangedSubview($0)
        }
        
        return view
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        
        self.imageView.image = self.interactor?.photo
        self.titleLabel.text = self.interactor?.title
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailsSceneInteractor()
        let presenter = DetailsScenePresenter()
        let router = DetailsSceneRouter(sceneFactory: DefaultSceneFactory())
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.containerView)
        
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
