//
//  SessionDataSource.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import Foundation

class SessionDataSource {
    
    static func closeSession() {
        UserDefaults.standard.setValue(nil, forKey: UserDefaultsKeys.user.rawValue)
        SessionUserDataSource.shared.clear()
        SessionQuizDataSource.shared.clear()
    }
}
