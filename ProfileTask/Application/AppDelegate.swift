//
//  AppDelegate.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController.init()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.startMainVC()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

