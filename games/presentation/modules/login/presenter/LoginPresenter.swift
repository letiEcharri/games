//  
//  LoginPresenter.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit
import Firebase

class LoginPresenter: BasePresenter, LoginPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var signalDelegate: LoginSignalDelegate?
    
    weak var ui: LoginPresenterDelegate?
    private let interactor: LoginInteractorProtocol = LoginInteractor.shared
    
    // MARK: - Initialization
    
    init(signalDelegate: LoginSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - LoginPresenter Functions
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.interactor.checkAuth { (userID) in
            if userID != nil {
                self.signalDelegate?.signalTrigged(.home)
            }
        }
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        interactor.unlinkFirebaseAuth()
    }
    
    func login(user: String, pass: String) {
        interactor.signIn(email: user.lowercased(), pass: pass) { (response) in
            
            switch response {
            case .success:
                self.ui?.clearFields()
            case .failure(let error):
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func signUp(email: String, pass: String) {
        interactor.signUp(email: email.lowercased(), pass: pass) { (response) in
            switch response {
            case .success:
                break
            case .failure(let error):
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func checkSignUpFields(email: String, pass: String, completion: @escaping (String?) -> Void) {
        if email != "" && pass != "" {
            if isValidEmail(email) {
                if pass.count > 5 {
                    completion(nil)
                } else {
                    completion("login_signUp_error_pass".localized)
                }
            } else {
                completion("login_signUp_error_email".localized)
            }
        } else {
            completion("login_signUp_error_fields".localized)
        }
    }
    
    // MARK: Private functions
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
