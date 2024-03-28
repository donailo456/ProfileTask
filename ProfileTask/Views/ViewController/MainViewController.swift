//
//  ViewController.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: MainViewModel?
    
    // MARK: - Private properties
    
    private lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var adapter = CollectionViewAdapter(collectionView: mainCollectionView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(mainCollectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel?.getServices()
        
        viewModel?.onDataReload = { [weak self] data in
            self?.adapter.reload(data)
        }
    }

}

