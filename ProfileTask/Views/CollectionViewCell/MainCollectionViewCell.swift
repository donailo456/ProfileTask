//
//  MainCollectionViewCell.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    var urlString: String?
    
    static let identifier = "MainCollectionViewCell"
    
    // MARK: - Private properties
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal properties
    
    func configure(viewModel: MainCollectionViewCellModel?) {
        nameLabel.text = viewModel?.name
        discriptionLabel.text = viewModel?.description
        imageView.image = UIImage(data: viewModel?.iconData ?? Data())
        urlString = viewModel?.link
    }
    
    // MARK: - Private Methods
    
    private func setupContentView() {
        contentView.backgroundColor = UIColor.hexStringToUIColor(hex: "5d5f61")
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 3
        contentView.layer.cornerRadius = 10
    }
    
    private func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(discriptionLabel)
        self.contentView.addSubview(imageView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 76),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            
            discriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            discriptionLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            discriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            discriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}
