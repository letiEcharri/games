//
//  HomePresenter.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import Foundation

class HomePresenter: BasePresenter, HomePresenterProtocol {
    
    // MARK: - Properties
    
    var ui: HomePresenterDelegate?
    private var signalDelegate: HomeSignalDelegate
    
    init(signalDelegate: HomeSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
}
