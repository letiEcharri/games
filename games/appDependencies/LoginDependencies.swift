//
//  LoginDependencies.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//

import Foundation

protocol LoginDependencies {
    func makeLoginView(signalDelegate: LoginSignalDelegate) -> LoginViewController
}

extension AppDependencies: LoginDependencies {
    
    func makeLoginView(signalDelegate: LoginSignalDelegate) -> LoginViewController {
        let presenter = LoginPresenter(signalDelegate: signalDelegate)
        let viewContoller = LoginViewController(presenter)
        
        presenter.ui = viewContoller
        
        return viewContoller
    }
}
