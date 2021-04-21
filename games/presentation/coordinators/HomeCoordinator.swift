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
    private var userID: String
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController, userID: String) {
        self.navigationController = navigationController
        self.userID = userID
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToHomeRanking()
    }
    
    // MARK: - HomeCoordinator Functions
    
    private func navigateToHome() {
        let viewController = appDependencies.makeHomeView(signalDelegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateTo(_ destination: ToolbarDestination) {
        childCoordinator = ToolbarCoordinator(navigationController, destination: destination)
        childCoordinator?.resolve()
    }
    
    private func navigateToHomeRanking() {
        let viewController = appDependencies.makeHomeRankingView(signalDelegate: self, userID: userID)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: Coordinator Delegate

extension HomeCoordinator: HomeSignalDelegate {
    func signalTrigged(_ signal: HomeSignal) {
        switch signal {
        case .mainMenu:
            navigateTo(.mainMenu)
        case .profile:
            navigateTo(.userProfile)
        }
    }
}

extension HomeCoordinator: HomeRankingSignalDelegate {
    func signalTrigged(_ signal: HomeRankingSignal) {
        switch signal {
        case .mainMenu:
            navigateTo(.mainMenu)
        case .userProfile:
            navigateTo(.userProfile)
        }
    }
}
