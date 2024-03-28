//
//  MainCollectionViewCell.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    static let identifier = "MainCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal properties
    
    func configure(viewModel: MainCollectionViewCellModel?) {
        debugPrint(viewModel)
    }
}
