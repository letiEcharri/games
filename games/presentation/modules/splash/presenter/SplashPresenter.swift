//  
//  SplashPresenter.swift
//  games
//
//  Created by Leticia Personal on 23/04/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class SplashPresenter: BasePresenter, SplashPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var signalDelegate: SplashSignalDelegate?
    
    weak var ui: SplashPresenterDelegate?
    private let interactor: UserInteractorProtocol = UserInteractor.shared
    
    // MARK: - Initialization
    
    init(signalDelegate: SplashSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - SplashPresenter Functions
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
            self.interactor.checkAuth { (userID) in
                if let userID = userID {
                    self.signalDelegate?.signalTrigged(.home(userID))
                } else {
                    self.signalDelegate?.signalTrigged(.login)
                }
            }
        }
    }
    
}
