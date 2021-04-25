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
    func editUser(field: UserDataSource.Edit, value: Any, completion: @escaping FirebaseUpdateResponseBlock)
    func getUser(completion: @escaping UserResponseBlock)
    func getTopUsers(completion: @escaping TopUsersResponseBlock)
    func signOut()
}
