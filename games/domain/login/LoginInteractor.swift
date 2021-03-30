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
    
    func login(user: String, pass: String, completion: @escaping LoginRepositoryBlock) {
        repository.login(user: user, pass: pass, completion: completion)
    }
    
    func singUp(user: UserModel, password: String, completion: @escaping ResponseBlock) {
        repository.singUp(user: user, password: password, completion: completion)
    }
}
