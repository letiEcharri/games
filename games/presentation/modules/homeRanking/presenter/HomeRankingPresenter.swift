//  
//  HomeRankingPresenter.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class HomeRankingPresenter: BasePresenter, HomeRankingPresenterProtocol {
    
    enum Tab {
        case score
        case ranking
    }
    
    // MARK: - Properties
    
    private weak var signalDelegate: HomeRankingSignalDelegate?
    private var userInteractor: UserInteractorProtocol = UserInteractor.shared
    
    weak var ui: HomeRankingPresenterDelegate?
    var user: UserModel?
    var topUsers: [UserModel]?
    var selectedTAB: Tab = .score
    
    // MARK: - Initialization
    
    init(signalDelegate: HomeRankingSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - HomeRankingPresenter Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if user == nil {
            userInteractor.getUser { (userModel, error) in
                
                if let userModel = userModel {
                    self.user = userModel
                    self.ui?.reloadData()
                    
                } else if let error = error {
                    let viewModel = InfoAlertModel(type: .error, description: error)
                    self.ui?.showAlert(with: viewModel)
                }
            }
        }
        
    }
    
    func select(tab: Tab) {
        selectedTAB = tab
        
        if selectedTAB == .ranking, topUsers == nil {
            userInteractor.getTopUsers { (users, error) in
                
                if let users = users {
                    self.topUsers = users
                    self.ui?.reloadData()
                    
                } else if let error = error {
                    let viewModel = InfoAlertModel(type: .error, description: error)
                    self.ui?.showAlert(with: viewModel)
                }
            }
        } else {
            self.ui?.reloadData()
        }
    }
    
    func goToMainMenu() {
        signalDelegate?.signalTrigged(.mainMenu)
    }
    
    func goToUserProfile() {
        signalDelegate?.signalTrigged(.userProfile)
    }
}
