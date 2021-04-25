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
    
    func editUser(field: UserDataSource.Edit, value: Any, completion: @escaping FirebaseUpdateResponseBlock) {
        repository.editUser(field: field, value: value, completion: completion)
    }
    
    func getUser(completion: @escaping UserResponseBlock) {
        repository.getUser(completion: completion)
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        repository.getTopUsers(completion: completion)
    }
    
    func signOut() {
        repository.signOut()
    }
}
