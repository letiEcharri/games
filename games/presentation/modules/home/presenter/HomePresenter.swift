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
    private var userInteractor: UserInteractorProtocol = UserInteractor.shared
    
    var user: UserModel?
    
    // MARK: - Initialization
    
    init(signalDelegate: HomeSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear() {
        userInteractor.getUser() { (user, error) in
            if let user = user {
                self.user = user
                self.ui?.reloadData()
            }
        }
    }
    
    
    // MARK: - Presenter Functions
    
    func play() {
        signalDelegate.signalTrigged(.mainMenu)
    }
    
    func goToProfile() {
        signalDelegate.signalTrigged(.profile)
    }
}
