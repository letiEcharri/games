//
//  UserRepositoryProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias UserResponseBlock = (Result<UserModel, Error>) -> Void
typealias LoginRepositoryBlock = (Bool, Error?) -> Void
typealias TopUsersResponseBlock = (Result<[UserModel], Error>) -> Void


protocol UserRepositoryProtocol {
    func unlinkFirebaseAuth()
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock)
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
    
    func getUser(userID: String, completion: @escaping UserResponseBlock)
    func update(score: Int)
    func update(email: String)
    func update(password: String)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
