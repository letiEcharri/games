//
//  UserDataSourceProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

protocol UserDataSourceProtocol {
    func getUser(nick: String, completion: @escaping UserResponseBlock)
}
