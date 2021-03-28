//
//  HomeDependencies.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

protocol HomeDependencies {
    func makeHomeView(signalDelegate: HomeSignalDelegate) -> HomeViewController
}

extension AppDependencies: HomeDependencies {
    
    func makeHomeView(signalDelegate: HomeSignalDelegate) -> HomeViewController {
        
        let presenter = HomePresenter(signalDelegate: signalDelegate)
        let viewController = HomeViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
