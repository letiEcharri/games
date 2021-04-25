//
//  AlertDependencies.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import Foundation

protocol AlertDependencies {
    func makeInfoAlertView(with viewModel: InfoAlertModel) -> InfoAlertViewController
}

extension AppDependencies: AlertDependencies {
    func makeInfoAlertView(with viewModel: InfoAlertModel) -> InfoAlertViewController {
        let viewController = InfoAlertViewController(viewModel)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        
        return viewController
    }
}
