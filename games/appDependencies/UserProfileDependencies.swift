//
//  UserProfileDependencies.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import Foundation

protocol UserProfileDependencies {
    func makeUserProfileView(signalDelegate: UserProfileSignalDelegate) -> UserProfileViewController
}

extension AppDependencies: UserProfileDependencies {
    
    func makeUserProfileView(signalDelegate: UserProfileSignalDelegate) -> UserProfileViewController {
        
        let presenter = UserProfilePresenter(signalDelegate: signalDelegate)
        let viewController = UserProfileViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
