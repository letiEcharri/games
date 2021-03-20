//
//  UserRepositoryProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

typealias UserResponseBlock = (UserModel?, Error?) -> Void

protocol UserRepositoryProtocol {
    func getUser(nick: String, completion: @escaping UserResponseBlock)
    func update(score: Int)
}
