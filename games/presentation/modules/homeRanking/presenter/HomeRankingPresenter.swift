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
//    private var userID: String
    
    var numberOfRows: Int {
        switch selectedTAB {
        case .score:
            return user != nil ? 1 : 0
        case .ranking:
            if let topUsers = topUsers {
                return topUsers.count + 1
            }
        }
        return 0
    }
    
    // MARK: - Initialization
    
    init(signalDelegate: HomeRankingSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - HomeRankingPresenter Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        userInteractor.unlinkFirebaseAuth()
        
        userInteractor.getUser { (response) in
            switch response {
            case .success(let userModel):
                self.user = userModel
                if userModel.nick == "" {
                    self.createUser()
                } else {
                    self.ui?.reloadData()
                }
            case .failure(let error):
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription) {
                    self.signalDelegate?.signalTrigged(.login)
                }
                self.ui?.showAlert(with: viewModel)
            }
        }
        
    }
    
    func select(tab: Tab) {
        selectedTAB = tab
        
        if selectedTAB == .ranking, topUsers == nil {
            userInteractor.getTopUsers { (response) in
                switch response {
                case .success(let users):
                    self.topUsers = users
                    self.ui?.reloadData()
                    
                case .failure(let error):
                    let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
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
    
    // MARK: Private functions
    
    private func createUser() {
        if let user = self.user {
            userInteractor.createUser(with: user) { (error) in
                if let error = error {
                    print(error)
                }
                self.ui?.reloadData()
            }
        }
    }
}
