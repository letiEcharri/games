//
//  UserDataSource.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class UserDataSource: DataSource, UserDataSourceProtocol {
    
    static let shared: UserDataSourceProtocol = UserDataSource()
    
    func getUser(nick: String, completion: @escaping UserResponseBlock) {
        FirebaseManager.getValue(from: .users) { (response, error) in
            if let response = response {
                if let users = response as? NSArray {
                    for item in users {
                        if let selectedItem = item as? [String: Any],
                           let key = selectedItem["nick"] as? String {
                            if key == nick {
                                            
                                do {
                                    let jsonData = try JSONSerialization.data(withJSONObject: selectedItem, options: .prettyPrinted)
                                    let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                                    completion(model, nil)
                                    
                                } catch {
                                    completion(nil, error)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
