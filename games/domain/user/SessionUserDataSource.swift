//
//  SessionUserDataSource.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class SessionUserDataSource {
    
    static let shared = SessionUserDataSource()
    
    var user: UserModel?
    
    func clear() {
        user = nil
    }
}
