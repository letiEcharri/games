//
//  LoginCoordinator.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies: LoginDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToLogin()
    }
    
    // MARK: - Functions
    
    private func navigateToLogin() {
        let viewContoller = appDependencies.makeLoginView(signalDelegate: self)
        navigationController.pushViewController(viewContoller, animated: true)
    }
}

extension LoginCoordinator: LoginSignalDelegate {
    func signalTrigged(_ signal: LoginSignal) {
        
    }
}
