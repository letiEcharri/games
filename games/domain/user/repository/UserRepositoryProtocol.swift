//
//  UserRepositoryProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias UserResponseBlock = (UserModel?, String?) -> Void
typealias LoginRepositoryBlock = (Bool, Error?) -> Void


protocol UserRepositoryProtocol {
    func getUser(completion: @escaping UserResponseBlock)
    func update(score: Int)
    func login(user: String, pass: String, completion: @escaping LoginRepositoryBlock)
}
