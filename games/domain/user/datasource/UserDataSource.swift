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
                                    completion(nil, error.localizedDescription)
                                }
                            }
                        }
                    }
                }
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
    func update(score: Int, with userID: Int) {
        let item = "\(userID)/score"
        FirebaseManager.update(from: .users, item: item, value: score)
    }
    
    func login(user: String, pass: String, completion: @escaping LoginResponseBlock) {
        FirebaseManager.getValue(from: .users) { (response, error) in
            if let response = response {
                if let users = response as? NSArray {
                    for item in users {
                        if let selectedItem = item as? [String: Any],
                           let key = selectedItem["nick"] as? String,
                           let password = selectedItem["password"] as? String {
                            if key == user {
                                do {
                                    let jsonData = try JSONSerialization.data(withJSONObject: selectedItem, options: .prettyPrinted)
                                    let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                                    completion(pass == password, model, nil)
                                    
                                } catch {
                                    completion(pass == password, nil, error)
                                }
                                return
                            }
                        }
                    }
                }
                let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                completion(false, nil, error)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}
