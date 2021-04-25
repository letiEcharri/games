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
        let viewController = AppDependencies().makeLoginView(signalDelegate: self)
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
    
    private func navigateToHome() {
        if let navigationController = navigationController {
            childCoordinator = HomeCoordinator(navigationController)
            childCoordinator?.resolve()
        }
    }
}

// MARK: Coordinator Delegate

extension AppCoordinator: LoginSignalDelegate {
    func signalTrigged(_ signal: LoginSignal) {
        switch signal {
        case .home:
            navigateToHome()
        }
    }
}
