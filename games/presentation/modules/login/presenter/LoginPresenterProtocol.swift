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
    
}

protocol LoginSignalDelegate: class {
    func signalTrigged(_ signal: LoginSignal)
}

protocol LoginPresenterProtocol where Self: BasePresenter {
    
    var ui: LoginPresenterDelegate? { get set }
    
    func login(user: String, pass: String)
}

protocol LoginPresenterDelegate: BasePresenterDelegate {
    
}
