//
//  ToolbarCoordinator.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import UIKit

enum ToolbarDestination {
    case home(_ userID: String)
    case mainMenu
    case userProfile
}

class ToolbarCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    var destination: ToolbarDestination
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController, destination: ToolbarDestination) {
        self.navigationController = navigationController
        self.destination = destination
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        switch destination {
        case .home(let userID):
            navigateToHome(userID: userID)
        case .mainMenu:
            navigateToMainMenu()
        case .userProfile:
            navigateToUserProfile()
        }
    }
    
    // MARK: - Functions
    
    private func navigateToMainMenu() {
        childCoordinator = MainMenuCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateToHome(userID: String) {
        childCoordinator = HomeCoordinator(navigationController, userID: userID)
        childCoordinator?.resolve()
    }
    
    private func navigateToUserProfile() {
        childCoordinator = UserProfileCoordinator(navigationController)
        childCoordinator?.resolve()
    }
}
