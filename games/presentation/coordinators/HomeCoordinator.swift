//
//  HomeCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies: HomeDependencies = AppDependencies()
    let userDependencies: UserProfileDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToHome()
    }
    
    // MARK: - HomeCoordinator Functions
    
    private func navigateToHome() {
        let viewController = appDependencies.makeHomeView(signalDelegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToMainMenu() {
        childCoordinator = MainMenuCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateToUserProfile() {
        let viewController = userDependencies.makeUserProfileView()
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: Coordinator Delegate

extension HomeCoordinator: HomeSignalDelegate {
    func signalTrigged(_ signal: HomeSignal) {
        switch signal {
        case .mainMenu:
            navigateToMainMenu()
        case .profile:
            navigateToUserProfile()
        }
    }
}
