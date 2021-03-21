//  
//  LoginPresenter.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class LoginPresenter: BasePresenter, LoginPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var signalDelegate: LoginSignalDelegate?
    
    weak var ui: LoginPresenterDelegate?
    private let interactor: LoginInteractorProtocol = LoginInteractor.shared
    
    // MARK: - Initialization
    
    init(signalDelegate: LoginSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - LoginPresenter Functions
    
    func login(user: String, pass: String) {
        self.ui?.showLoading()
        interactor.login(user: user, pass: pass) { (isSuccess, error) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.signalDelegate?.signalTrigged(.home)
                }
            } else {
                // TODO: Alert with error
            }
        }
    }
}
