//
//  UserDataSourceProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias LoginResponseBlock = (Bool, UserModel?, Error?) -> Void

protocol UserDataSourceProtocol {
    func getUser(nick: String, completion: @escaping UserResponseBlock)
    func update(score: Int, with userID: Int)
    func login(user: String, pass: String, completion: @escaping LoginResponseBlock)
}
