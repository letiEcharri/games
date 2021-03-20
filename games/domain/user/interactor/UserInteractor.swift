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
    
    func getUser(nick: String, completion: @escaping UserResponseBlock) {
        repository.getUser(nick: nick, completion: completion)
    }
    
    func update(score: Int) {
        repository.update(score: score)
    }
}
