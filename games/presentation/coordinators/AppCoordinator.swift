//
//  AppCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
        
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?
    
    // MARK: - Init
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        if UserDefaults.standard.string(forKey: UserDefaultsKeys.user.rawValue) != nil {
            navigateToHome()
        } else {
            navigateToLogin()
        }
    }
    
    private func navigateToHome() {
        childCoordinator = HomeCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateToLogin() {
        childCoordinator = LoginCoordinator(navigationController)
        childCoordinator?.resolve()
    }
}
