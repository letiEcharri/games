//
//  HomePresenter.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomePresenter: BasePresenter, HomePresenterProtocol {
    
    // MARK: - Properties
    
    var ui: HomePresenterDelegate?
    private var signalDelegate: HomeSignalDelegate
    
    var user: UserModel?
    
    init(signalDelegate: HomeSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    override func viewWillAppear() {
        user = UserModel(nick: "Coca-Cola", score: 100) // TODO: Get from service
        self.ui?.reloadData()
    }
    
    
    // MARK: - Presenter Functions
    
    func play() {
        // TODO: Navigate to next screen
    }
}
