//
//  UserRepositoryProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias UserResponseBlock = (UserModel?, String?) -> Void
typealias LoginRepositoryBlock = (Bool, Error?) -> Void
typealias TopUsersResponseBlock = ([UserModel]?, String?) -> Void


protocol UserRepositoryProtocol {
    func checkAuth(completion: @escaping FirebaseAuthBlock)
    func unlinkFirebaseAuth()
    func signUp(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
    
    func getUser(completion: @escaping UserResponseBlock)
    func update(score: Int)
    func update(email: String)
    func update(password: String)
    func login(user: String, pass: String, completion: @escaping LoginRepositoryBlock)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
