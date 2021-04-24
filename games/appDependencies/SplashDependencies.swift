//
//  SplashDependencies.swift
//  games
//
//  Created by Leticia Personal on 23/04/2021.
//

import Foundation

protocol SplashDependencies {
    func makeSplashView(signalDelegate: SplashSignalDelegate) -> SplashViewController
}

extension AppDependencies: SplashDependencies {
    
    func makeSplashView(signalDelegate: SplashSignalDelegate) -> SplashViewController {
        
        let presenter = SplashPresenter(signalDelegate: signalDelegate)
        let viewController = SplashViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
