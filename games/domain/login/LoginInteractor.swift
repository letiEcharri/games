//  
//  LoginInteractor.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {
    
    // MARK: - Properties
    
    static let shared: LoginInteractorProtocol = LoginInteractor()
    
    let repository: UserRepositoryProtocol = UserRepository.shared
    
    // MARK: - LoginInteractor functions
    
    func unlinkFirebaseAuth() {
        repository.unlinkFirebaseAuth()
    }
    
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock) {
        repository.signUp(email: email, pass: pass, completion: completion)
    }
    
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock) {
        repository.signIn(email: email, pass: pass, completion: completion)
    }
}
