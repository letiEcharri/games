//
//  UserInteractorProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

protocol UserInteractorProtocol {
    func unlinkFirebaseAuth()
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock)
    func checkAuth(completion: @escaping (String?) -> Void) 
    
    func getUser(userID: String, completion: @escaping UserResponseBlock)
    func update(score: Int)
    func update(email: String)
    func update(password: String)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
