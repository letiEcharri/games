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
    func signOut()
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock)
    func checkAuth(completion: @escaping (String?) -> Void)
    func editUser(field: UserDataSource.Edit, with userID: String, value: Any, completion: @escaping FirebaseUpdateResponseBlock)
    func getUser(completion: @escaping UserResponseBlock)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
