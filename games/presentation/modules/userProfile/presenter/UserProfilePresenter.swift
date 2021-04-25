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
        
        interactor.getUser { (response) in
            switch response {
            case .success(let user):
                self.user = user
                self.ui?.reloadData()
                
            case .failure(let error):
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription) {
                    self.signalDelegate?.signalTrigged(.closeSession)
                }
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func textfieldAction(isSecureEntry: Bool, text: String) {
        interactor.editUser(field: isSecureEntry ? .password : .nick, value: text) { (error) in
            if let error = error {
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func update(image: UIImage) {
        if let name = image.accessibilityIdentifier {
            interactor.editUser(field: .image, value: name) { (error) in }
        }
    }
    
    func goToHome() {
        signalDelegate?.signalTrigged(.home)
    }
    
    func goToMainMenu() {
        signalDelegate?.signalTrigged(.mainMenu)
    }
    
    func closeSession() {
        interactor.signOut()
        signalDelegate?.signalTrigged(.closeSession)
    }
}
