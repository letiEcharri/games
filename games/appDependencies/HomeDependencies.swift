//
//  HomeDependencies.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

protocol HomeDependencies {
    func makeHomeView(signalDelegate: HomeSignalDelegate) -> HomeViewController
    func makeHomeRankingView(signalDelegate: HomeRankingSignalDelegate) -> HomeRankingViewController
}

extension AppDependencies: HomeDependencies {
    
    func makeHomeView(signalDelegate: HomeSignalDelegate) -> HomeViewController {
        
        let presenter = HomePresenter(signalDelegate: signalDelegate)
        let viewController = HomeViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
    
    func makeHomeRankingView(signalDelegate: HomeRankingSignalDelegate) -> HomeRankingViewController {
        
        let presenter = HomeRankingPresenter(signalDelegate: signalDelegate)
        let viewController = HomeRankingViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
