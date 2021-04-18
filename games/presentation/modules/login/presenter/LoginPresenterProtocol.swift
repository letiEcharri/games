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
    
    func login(user: String, pass: String)
    func signUp(email: String, pass: String)
    func checkSignUpFields(email: String, pass: String, completion: @escaping (String?) -> Void)
}

protocol LoginPresenterDelegate: BasePresenterDelegate {
    
}
