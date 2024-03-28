//
//  CollectionViewAdapter.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class CollectionViewAdapter: NSObject {
    
    // MARK: - Constants
    
    enum Section {
        case main
    }
    
    private enum Constants {
        static let minimumSpaceCell: CGFloat = 3
        static let insertCellTop: CGFloat = 16
        static let insertCellLeft: CGFloat = 16
        static let insertCellBottom: CGFloat = 16
        static let insertCellRight: CGFloat = 16
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MainCollectionViewCellModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, MainCollectionViewCellModel>
    
    // MARK: - Private properties
    
    private weak var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    private var cellDataSource: [MainCollectionViewCellModel]?
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        setupCollectionView()
    }
    
    // MARK: - Internal Methods
    
    func reload(_ data: [MainCollectionViewCellModel]?) {
        guard let data = data else { return }
        cellDataSource = data
        configureCollectionViewDataSource()
        applySnapshot(services: data)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        self.collectionView?.backgroundColor = .blue
        self.collectionView?.delegate = self
        self.collectionView?.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    private func applySnapshot(services: [MainCollectionViewCellModel]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(services)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionViewAdapter {
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView ?? UICollectionView(), cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell
            let cellViewModel = self.cellDataSource?[indexPath.row]
            cell?.configure(viewModel: cellViewModel)
            return cell
        })
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width - 32, height: collectionView.bounds.height / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.insertCellTop, left: Constants.insertCellLeft, bottom: Constants.insertCellBottom, right: Constants.insertCellRight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.minimumSpaceCell
    }
}
