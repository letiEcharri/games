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
        FirebaseManager.shared.checkAuth { [self] (userID) in
            if let userID = userID {
                navigateToHome(userID: userID)
            } else {
                navigateToLogin()
            }
        }
    }
    
    private func navigateToHome(userID: String) {
        childCoordinator = HomeCoordinator(navigationController, userID: userID)
        childCoordinator?.resolve()
    }
    
    private func navigateToLogin() {
        childCoordinator = LoginCoordinator(navigationController)
        childCoordinator?.resolve()
    }
}
