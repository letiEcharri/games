//
//  MainMenuPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

enum MainMenuSignal {
    case quiz
    case dayQuestion
    case home
    case profile
}

protocol MainMenuSignalDelegate: class {
    func signalTrigged(_ signal: MainMenuSignal)
}

protocol MainMenuPresenterProtocol where Self: BasePresenter {
    var ui: MainMenuPresenterDelegate? { get set }
    var sections: [MainMenuPresenter.Model] { get set }
    
    func didSelectSection(with row: Int)
    func goToHome()
    func goToProfile()
}

protocol MainMenuPresenterDelegate: BasePresenterDelegate {
    
}
