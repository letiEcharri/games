//
//  MainMenuDependencies.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

protocol MainMenuDependencies {
    func makeMainMenuView(signalDelegate: MainMenuSignalDelegate) -> MainMenuViewController
}

extension AppDependencies: MainMenuDependencies {
    
    func makeMainMenuView(signalDelegate: MainMenuSignalDelegate) -> MainMenuViewController {
        
        let presenter = MainMenuPresenter(signalDelegate: signalDelegate)
        let viewController = MainMenuViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
