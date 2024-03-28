//
//  MainViewModel.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class MainViewModel: NSObject, MainViewModelProtocol {
    
    // MARK: - Constants
    
    private enum Constants {
        static let endCell = 6
    }
    
    // MARK: - Internal properties
    
    weak var coordinator: AppCoordinator?
    
    var onDataReload: (([MainCollectionViewCellModel]?, Int?) -> Void)?
    var onIsLoading: ((Bool)-> Void)?
    
    // MARK: - Private properties
    
    private let networkService: NetworkService?
    private var dataSource: [Service]?
    private var cellDataSource: [MainCollectionViewCellModel]?
    private var limitCellDataSource: [MainCollectionViewCellModel]?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    
    func getServices() {
        onIsLoading?(true)
        networkService?.getServices { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let service):
                    self.dataSource = service
                    self.mapCellData()
                    self.paginationData(limit: 0)
                    self.onIsLoading?(false)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    func paginationData(limit: Int) {
        if limit != 0 && cellDataSource?.count ?? 0 >= limit + Constants.endCell {
            guard let data = cellDataSource?[limit + Constants.endCell] else { return }
            limitCellDataSource?.append(data)
            downloadDataIcon()
        }
    }
    
    // MARK: - Private Methods
    
    private func downloadDataIcon() {
        guard let dataSource = limitCellDataSource else { return }
        
        let group = DispatchGroup()
        let lock = NSLock()
        
        for index in dataSource.indices {
            group.enter()
            if let urlString = dataSource[index].iconURL, let url = URL(string: urlString) {
                if dataSource[index].iconData != nil {
                    group.leave()
                    continue
                }
                
                networkService?.downloadImage(from: url) { [weak self] data in
                    guard let self = self else { return }
                    
                    defer {
                        group.leave()
                    }
                    
                    lock.lock()
                    self.limitCellDataSource?[index].iconData = data
                    lock.unlock()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.onDataReload?(self.limitCellDataSource ?? [], (self.cellDataSource?.count ?? 0) - Constants.endCell - 1)
        }

    }
    
    private func mapCellData() {
        self.cellDataSource = dataSource?.compactMap({ MainCollectionViewCellModel(
            name: $0.name,
            description: $0.description,
            link: $0.link,
            iconURL: $0.icon_url,
            iconData: nil)
        })
        
        limitCellDataSource = cellDataSource?[0...Constants.endCell].compactMap({ MainCollectionViewCellModel(
            name: $0.name,
            description: $0.description,
            link: $0.link,
            iconURL: $0.iconURL,
            iconData: nil
        )})
        
        downloadDataIcon()
    }
}
