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
    
    func unlinkFirebaseAuth() {
        datasource.unlinkFirebaseAuth()
    }
    
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock) {
        datasource.signUp(email: email, pass: pass) { (response) in
            switch response {
            case .success(let user):
                self.session.user = user
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock) {
        datasource.signIn(email: email, pass: pass, completion: completion)
    }
    
    func getUser(userID: String, completion: @escaping UserResponseBlock) {
        if let sessionUser = self.session.user {
            completion(.success(sessionUser))
        } else {
            
            datasource.getUser(userID: userID) { (response) in
                switch response {
                case .success(let user):
                    self.session.user = user
                    completion(.success(user))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock) {
        datasource.createUser(with: model) { (error) in
            if error == nil {
                self.session.user = model
            }
            completion(error)
        }
    }
    
    func checkAuth(completion: @escaping (String?) -> Void) {
        datasource.checkAuth(completion: completion)
    }
    
    func update(score: Int) {
        session.user?.score += score
        if let user = session.user {
//            datasource.update(score: user.score, with: user.id)
        }
    }
    
    func update(email: String) {
        session.user?.email = email
        if let user = session.user {
//            datasource.update(email: user.email, with: user.id)
        }
    }
    
    func update(password: String) {
        if let user = session.user {
//            datasource.update(password: password, with: user.id)
        }
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        datasource.getTopUsers(completion: completion)
    }
}
