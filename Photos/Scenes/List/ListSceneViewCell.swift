//
//  ListViewCell.swift
//  3Commas_test_task
//
//  Created by Yurii Mamurko on 26.11.2022.
//

import UIKit

final class ListSceneViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.photoImageView)
        
        NSLayoutConstraint.activate([
            self.photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension ListSceneViewCell: Fillable {
    func fill(with model: PhotoProtocol?) {
        guard let model = model else { return }
        self.photoImageView.loadImageUsingCache(withUrl: model.url)
    }
}
