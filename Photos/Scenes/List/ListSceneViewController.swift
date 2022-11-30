//
//  ListViewController.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

protocol ListSceneDisplayLogic: AnyObject {
    func displayResult(viewModel: ListScene.PerformFetch.ViewModel)
    func displayError(error: String)
}

final class ListSceneViewController: UIViewController {
    
    // MARK: - Nested types
    
    private enum TableSection: Int {
        case photos
        case loader
    }
    
    // MARK: - Properties
    
    private var interactor: ListSceneBusinessLogic?
    private var router: ListSceneRoutingLogic?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(ListSceneViewCell.classForCoder(), forCellReuseIdentifier: "ListSceneViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - View lifecycle
    
    override func loadView() {
        super.loadView()
        self.configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.configureUI()
        self.interactor?.loadPhotos()
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let service = DefaultNetworkService()
        let worker = ListSceneWorker(service: service)
        let interactor = ListSceneInteractor()
        let presenter = ListScenePresenter()
        let router = ListSceneRouter(sceneFactory: DefaultSceneFactory())

        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.source = viewController
    }
    
    // MARK: - Private
    
    private func configureUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ListSceneViewController: ListSceneDisplayLogic {
    func displayResult(viewModel: ListScene.PerformFetch.ViewModel) {
        self.tableView.reloadData()
    }
    
    func displayError(error: String) {
        self.router?.routeToShowFailure(message: error)
    }
}

extension ListSceneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            let section = TableSection(rawValue: indexPath.section),
            let interactor = self.interactor
        else { return 0 }
        
        switch section {
        case .photos:
            return CGFloat(interactor.photos[indexPath.row].height)
        case .loader:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let section = TableSection(rawValue: section),
            let interactor = self.interactor
        else { return 0 }
        
        switch section {
        case .photos:
            return interactor.photos.count
        case .loader:
            return interactor.morePhotosLeft ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .photos:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListSceneViewCell", for: indexPath) as! ListSceneViewCell
            cell.fill(with: self.interactor?.photos[indexPath.row])
            return cell
        case .loader:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "LoadingCell")
            var content = cell.defaultContentConfiguration()
            
            content.text = "Loading..."
            content.textProperties.color = .systemBlue
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension ListSceneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let section = TableSection(rawValue: indexPath.section),
            let interactor = self.interactor,
            !interactor.photos.isEmpty,
            section == .loader
        else { return }
        
        interactor.loadPhotos()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let section = TableSection(rawValue: indexPath.section),
            let photos = self.interactor?.photos,
            section == .photos,
            let cell = tableView.cellForRow(at: indexPath) as? ListSceneViewCell,
            let image = cell.photoImageView.image
        else { return }
        
        self.router?.routeToShowPhoto(image: image, title: photos[indexPath.row].title)
    }
}
