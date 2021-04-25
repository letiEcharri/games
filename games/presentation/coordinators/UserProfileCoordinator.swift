//
//  UserProfileCoordinator.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import UIKit

class UserProfileCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies: UserProfileDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToUserProfile()
    }
    
    // MARK: - Functions
    
    private func navigateToUserProfile() {
        let viewController = appDependencies.makeUserProfileView(signalDelegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateTo(_ destination: ToolbarDestination) {
        childCoordinator = ToolbarCoordinator(navigationController, destination: destination)
        childCoordinator?.resolve()
    }
}

// MARK: Coordinator Delegate

extension UserProfileCoordinator: UserProfileSignalDelegate {
    func signalTrigged(_ signal: UserProfileSignal) {
        switch signal {
        case .home:
            navigateTo(.home)
        case .mainMenu:
            navigateTo(.mainMenu)
        case .closeSession:
            navigationController.popToRootViewController(animated: false)
        }
    }
}
