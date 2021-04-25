//
//  HomeCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var homeNavController: UINavigationController?
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
    
    private func navigateTo(_ destination: ToolbarDestination) {
        if let homeNavController = homeNavController {
            childCoordinator = ToolbarCoordinator(homeNavController, destination: destination)
            childCoordinator?.resolve()
        }
    }
    
    private func navigateToHomeRanking() {
        let viewController = appDependencies.makeHomeRankingView(signalDelegate: self, userID: userID)
        homeNavController = UINavigationController(rootViewController: viewController)
        if let homeNavController = homeNavController {
            homeNavController.modalPresentationStyle = .fullScreen
            navigationController.present(homeNavController, animated: true)
        }
    }
}

// MARK: Coordinator Delegate

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
