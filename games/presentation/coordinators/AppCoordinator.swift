//
//  AppCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
        
    var navigationController: UINavigationController?
    var childCoordinator: Coordinator?
    var window: UIWindow
    
    // MARK: - Init
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        let viewController = AppDependencies().makeSplashView(signalDelegate: self)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
    
    private func navigateToHome(userID: String) {
        if let navigationController = navigationController {
            childCoordinator = HomeCoordinator(navigationController, userID: userID)
            childCoordinator?.resolve()
        }
    }
    
    private func navigateToLogin() {
        if let navigationController = navigationController {
            childCoordinator = LoginCoordinator(navigationController)
            childCoordinator?.resolve()
        }
    }
}

extension AppCoordinator: SplashSignalDelegate {
    func signalTrigged(_ signal: SplashSignal) {
        switch signal {
        case .login:
            navigateToLogin()
        case .home(let userID):
            navigateToHome(userID: userID)
        }
    }
}
