//
//  HomeCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies = AppDependencies()
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
}

// MARK: Coordinator Delegate

extension HomeCoordinator: HomeSignalDelegate {
    func signalTrigged(_ signal: HomeSignal) {
        
    }
}

enum HomeSignal {
    
}

protocol HomeSignalDelegate: class {
    func signalTrigged(_ signal: HomeSignal)
}
