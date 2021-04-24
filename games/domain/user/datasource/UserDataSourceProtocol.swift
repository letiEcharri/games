//
//  UserDataSourceProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias LoginResponseBlock = (Bool, UserModel?, Error?) -> Void
typealias FirebaseAuthBlock = (Result<UserModel, Error>) -> Void
typealias SignUpResponseBlock = (Result<UserModel, Error>) -> Void
typealias SignLoginResponseBlock = (Result<String, Error>) -> Void

enum UserDefaultsKeys: String {
    case user
    case image
}

protocol UserDataSourceProtocol {
    func unlinkFirebaseAuth()
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock)
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock)
    func checkAuth(completion: @escaping (String?) -> Void) 
    
    func getUser(userID: String, completion: @escaping UserResponseBlock)
    func update(score: Int, with userID: Int)
    func update(email: String, with userID: Int)
    func update(password: String, with userID: Int)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
