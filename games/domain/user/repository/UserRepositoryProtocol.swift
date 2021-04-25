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
    func signOut()
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock)
    func checkAuth(completion: @escaping (String?) -> Void)
    func editUser(field: UserDataSource.Edit, value: Any, completion: @escaping FirebaseUpdateResponseBlock)
    func getUser(completion: @escaping UserResponseBlock)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
}
