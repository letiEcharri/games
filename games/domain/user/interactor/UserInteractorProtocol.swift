//
//  UserInteractorProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

protocol UserInteractorProtocol {
    func getUser(completion: @escaping UserResponseBlock)
    func update(score: Int)
    func update(email: String)
    func update(password: String)
}
