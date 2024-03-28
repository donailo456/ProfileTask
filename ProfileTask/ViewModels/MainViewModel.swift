//
//  MainViewModel.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class MainViewModel: NSObject {
    
    // MARK: - Internal properties
    
    weak var coordinator: AppCoordinator?
    
    var onDataReload: (([MainCollectionViewCellModel]?) -> Void)?
    
    // MARK: - Private properties
    
    private let networkService: NetworkService?
    private var dataSource: [Service]?
    private var cellDataSource: [MainCollectionViewCellModel]?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    
    func getServices() {
        networkService?.getServices { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let service):
                    self.dataSource = service
                    self.mapCellData()
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func mapCellData() {
        self.cellDataSource = dataSource?.compactMap({ MainCollectionViewCellModel(
            name: $0.name,
            description: $0.description,
            link: $0.link,
            iconURL: $0.icon_url,
            iconData: nil)
        })
        onDataReload?(cellDataSource)
    }
}
