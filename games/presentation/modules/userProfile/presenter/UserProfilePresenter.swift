//  
//  UserProfilePresenter.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class UserProfilePresenter: BasePresenter, UserProfilePresenterProtocol {
    
    // MARK: - Properties
    
    private weak var signalDelegate: UserProfileSignalDelegate?
        
    weak var ui: UserProfilePresenterDelegate?
    var user: UserModel?
    
    private let interactor: UserInteractorProtocol = UserInteractor.shared
    
    // MARK: - Initialization
    
    init(signalDelegate: UserProfileSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - UserProfilePresenter Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
//        interactor.getUser { (userModel, error) in
//            if let userModel = userModel {
//                self.user = userModel
//                self.ui?.reloadData()
//                
//            } else if let error = error {
//                let viewModel = InfoAlertModel(type: .error, description: error)
//                self.ui?.showAlert(with: viewModel)
//            }
//        }
    }
    
    func textfieldAction(isSecureEntry: Bool, text: String) {
        if isSecureEntry {
            interactor.update(password: text)
        } else {
            interactor.update(email: text)
        }
    }
    
    func goToHome() {
        // TODO: userID
        signalDelegate?.signalTrigged(.home(""))
    }
    
    func goToMainMenu() {
        signalDelegate?.signalTrigged(.mainMenu)
    }
    
    func closeSession() {
        signalDelegate?.signalTrigged(.closeSession)
    }
}
