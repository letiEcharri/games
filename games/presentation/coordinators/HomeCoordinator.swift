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
        navigateToHomeRanking()
    }
    
    // MARK: - HomeCoordinator Functions
    
    private func navigateTo(_ destination: ToolbarDestination) {
        childCoordinator = ToolbarCoordinator(navigationController, destination: destination)
        childCoordinator?.resolve()
    }
    
    private func navigateToHomeRanking() {
        let viewController = appDependencies.makeHomeRankingView(signalDelegate: self)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.pushViewController(viewController, animated: true)
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
        case .login:
            navigationController.popToRootViewController(animated: false)
        }
    }
}
