//
//  AppCooedinator.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Internal properties
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Methods
    
    func startMainVC() {
        showMainVC()
    }
    
    func startWebVC(url: URL) {
        showWebVC(url: url)
    }
    
    // MARK: - Private Methods
    
    private func showMainVC() {
        let mainViewController = MainViewController()
        let networkService = NetworkService()
        let fileManager = FilesManager()
        let mainViewModel = MainViewModel.init(networkService: networkService, filesManager: fileManager)
        mainViewModel.coordinator = self
        
        mainViewController.viewModel = mainViewModel
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: "141414")
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    private func showWebVC(url: URL) {
        let webViewController = WebViewController(url: url)

        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: "141414")
        navigationController.present(webViewController, animated: true)
    }
    
}
