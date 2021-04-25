//
//  SessionDataSource.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import Foundation

class SessionDataSource {
    
    static func closeSession() {
        SessionUserDataSource.shared.clear()
        SessionQuizDataSource.shared.clear()
    }
}
