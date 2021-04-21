//  
//  HomeRankingPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

// MARK: - ViewState

enum HomeRankingSignal {
    case mainMenu
    case userProfile
}

protocol HomeRankingSignalDelegate: class {
    func signalTrigged(_ signal: HomeRankingSignal)
}

protocol HomeRankingPresenterProtocol where Self: BasePresenter {
    
    var ui: HomeRankingPresenterDelegate? { get set }
    var user: UserModel? { get set }
    var selectedTAB: HomeRankingPresenter.Tab { get set }
    var topUsers: [UserModel]? { get set }
    var numberOfRows: Int { get }
    
    func select(tab: HomeRankingPresenter.Tab)
    func goToMainMenu()
    func goToUserProfile()
}

protocol HomeRankingPresenterDelegate: BasePresenterDelegate {
    
}
