//
//  UserRepository.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class UserRepository: UserRepositoryProtocol {
    
    static let shared: UserRepositoryProtocol = UserRepository()
    
    let session = SessionUserDataSource.shared
    let datasource: UserDataSourceProtocol = UserDataSource.shared
    
    func getUser(completion: @escaping UserResponseBlock) {
        if let sessionUser = self.session.user {
            completion(sessionUser, nil)
        } else {
            let id = UserDefaults.standard.integer(forKey: UserDefaultsKeys.user.rawValue)
            datasource.getUser(with: id) { (user, error) in
                self.session.user = user
                completion(user, nil)
            }
        }
    }
    
    func update(score: Int) {
        session.user?.score += score
        if let user = session.user {
            datasource.update(score: user.score, with: user.id)
        }
    }
    
    func update(email: String) {
        session.user?.email = email
        if let user = session.user {
            datasource.update(email: user.email, with: user.id)
        }
    }
    
    func update(password: String) {
        if let user = session.user {
            datasource.update(password: password, with: user.id)
        }
    }
    
    func login(user: String, pass: String, completion: @escaping LoginRepositoryBlock) {
        datasource.login(user: user, pass: pass) { (isSuccess, user, error) in
            self.session.user = user
            if isSuccess {
                UserDefaults.standard.setValue(user?.id, forKey: UserDefaultsKeys.user.rawValue)
            }
            completion(isSuccess, error)
        }
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        datasource.getTopUsers(completion: completion)
    }
    
    func singUp(user: UserModel, password: String, completion: @escaping ResponseBlock) {
        datasource.singUp(user: user, password: password) { (success, error) in
            self.session.user = user
            if success {
                UserDefaults.standard.setValue(user.id, forKey: UserDefaultsKeys.user.rawValue)
            }
            completion(success, error)
        }
    }
}
