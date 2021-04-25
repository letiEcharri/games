//
//  HomeDependencies.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

protocol HomeDependencies {
    func makeHomeRankingView(signalDelegate: HomeRankingSignalDelegate, userID: String) -> HomeRankingViewController
}

extension AppDependencies: HomeDependencies {
    
    func makeHomeRankingView(signalDelegate: HomeRankingSignalDelegate, userID: String) -> HomeRankingViewController {
        
        let presenter = HomeRankingPresenter(signalDelegate: signalDelegate, userID: userID)
        let viewController = HomeRankingViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
