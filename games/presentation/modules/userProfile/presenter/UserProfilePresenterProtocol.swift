//  
//  UserProfilePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

enum UserProfileSignal {
    case home
    case mainMenu
    case closeSession
}

protocol UserProfileSignalDelegate: class {
    func signalTrigged(_ signal: UserProfileSignal)
}

protocol UserProfilePresenterProtocol where Self: BasePresenter {
    
    var ui: UserProfilePresenterDelegate? { get set }
    var user: UserModel? { get }
    
    func textfieldAction(isSecureEntry: Bool, text: String)
    func goToHome()
    func goToMainMenu()
    func closeSession()
    func update(image: UIImage)
}

protocol UserProfilePresenterDelegate: BasePresenterDelegate {
    
}
