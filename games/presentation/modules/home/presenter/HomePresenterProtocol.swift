//
//  HomePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

enum HomeSignal {
    case mainMenu
    case profile
}

protocol HomeSignalDelegate: class {
    func signalTrigged(_ signal: HomeSignal)
}

protocol HomePresenterProtocol where Self: BasePresenter {
    
    var ui: HomePresenterDelegate? { get set }
    var user: UserModel? { get set }
    
    func play()
    func goToProfile()
}

protocol HomePresenterDelegate: BasePresenterDelegate {
    
}
