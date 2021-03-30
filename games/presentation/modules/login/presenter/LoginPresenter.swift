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
    
    var typeView: LoginViewController.TypeView = .login
    
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
            } else if let error = error {
                self.ui?.hideLoading()
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func singUp(nick: String, email: String, password: String) {
        let id = Int(Date().timeIntervalSince1970)
        let user = UserModel(id: id, nick: nick, score: 0, email: email)
        
        interactor.singUp(user: user, password: password) { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.signalDelegate?.signalTrigged(.home)
                }
            } else if let error = error {
                self.ui?.hideLoading()
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
}
