//  
//  LoginPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

// MARK: - ViewState

enum LoginSignal {
    case home
}

protocol LoginSignalDelegate: class {
    func signalTrigged(_ signal: LoginSignal)
}

protocol LoginPresenterProtocol where Self: BasePresenter {
    
    var ui: LoginPresenterDelegate? { get set }
    var typeView: LoginViewController.TypeView { get set }
    
    func login(user: String, pass: String)
    func singUp(nick: String, email: String, password: String)
}

protocol LoginPresenterDelegate: BasePresenterDelegate {
    
}
