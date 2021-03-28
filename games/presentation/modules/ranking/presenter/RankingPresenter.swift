//  
//  RankingPresenter.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class RankingPresenter: BasePresenter, RankingPresenterProtocol {
    
    // MARK: - Properties
        
    weak var ui: RankingPresenterDelegate?
    var users: [UserModel]?
    
    private var interactor: UserInteractorProtocol = UserInteractor.shared
    
    // MARK: - RankingPresenter Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.ui?.showLoading()
        interactor.getTopUsers { (topUsers, error) in
            self.users = topUsers
            self.ui?.hideLoading()
            
            if topUsers != nil {
                self.ui?.reloadData()
            } else if let error = error {
                let viewModel = InfoAlertModel(type: .error, description: error)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
}
