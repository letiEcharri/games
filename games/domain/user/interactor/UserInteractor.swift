//
//  UserInteractor.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class UserInteractor: UserInteractorProtocol {
    
    static let shared: UserInteractorProtocol = UserInteractor()
    
    let repository: UserRepositoryProtocol = UserRepository.shared
    
    func unlinkFirebaseAuth() {
        repository.unlinkFirebaseAuth()
    }
    
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock) {
        repository.createUser(with: model, completion: completion)
    }
    
    func checkAuth(completion: @escaping (String?) -> Void) {
        repository.checkAuth(completion: completion)
    }
    
    func getUser(userID: String, completion: @escaping UserResponseBlock) {
        repository.getUser(userID: userID, completion: completion)
    }
    
    func update(score: Int) {
        repository.update(score: score)
    }
    
    func update(email: String) {
        repository.update(email: email)
    }
    
    func update(password: String) {
        repository.update(password: password)
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        repository.getTopUsers(completion: completion)
    }
}
