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
    
    func getUser(nick: String, completion: @escaping UserResponseBlock) {
        if let sessionUser = self.session.user {
            completion(sessionUser, nil)
        } else {
            datasource.getUser(nick: nick) { (user, error) in
                if let user = user {
                    self.session.user = user
                }
                completion(user, error)
            }
        }
    }
    
    func update(score: Int) {
        session.user?.score += score
        if let user = session.user {
            datasource.update(score: user.score, with: user.id)
        }
    }
}
