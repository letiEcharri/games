//
//  MainMenuCoordinator.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class MainMenuCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToMainMenu()
    }
    
    // MARK: - HomeCoordinator Functions
    
    private func navigateToMainMenu() {
        let viewController = appDependencies.makeMainMenuView(signalDelegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToQuiz() {
        childCoordinator = QuizCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateTo(_ destination: ToolbarDestination) {
        childCoordinator = ToolbarCoordinator(navigationController, destination: destination)
        childCoordinator?.resolve()
    }
}

// MARK: - MainMenuSignalDelegate

extension MainMenuCoordinator: MainMenuSignalDelegate {
    func signalTrigged(_ signal: MainMenuSignal) {
        switch signal {
        case .quiz:
            navigateToQuiz()
        case .dayQuestion:
            break
        case .home:
            navigateTo(.home)
        case .profile:
            navigateTo(.userProfile)
        }
    }
}
