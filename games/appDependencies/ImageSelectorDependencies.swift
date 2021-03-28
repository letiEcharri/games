//
//  ImageSelectorDependencies.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//

import Foundation

protocol ImageSelectorDependencies {
    func makeImageSelector(delegate: ImageSelectorViewDelegate?) -> ImageSelectorViewController
}

extension AppDependencies: ImageSelectorDependencies {
    func makeImageSelector(delegate: ImageSelectorViewDelegate?) -> ImageSelectorViewController {
        
        let presenter = ImageSelectorPresenter()
        let viewController = ImageSelectorViewController(presenter, delegate: delegate)
        
        presenter.ui = viewController
        
        return viewController
    }
}
