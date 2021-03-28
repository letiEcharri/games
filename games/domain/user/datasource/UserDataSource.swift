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
                                    return
                                    
                                } catch {
                                    completion(nil, error.localizedDescription)
                                    return
                                }
                            }
                        }
                    }
                }
                completion(nil, "error_generic".localized)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
    func update(score: Int, with userID: Int) {
        let item = "\(userID)/score"
        FirebaseManager.update(from: .users, item: item, value: score)
    }
    
    func update(email: String, with userID: Int) {
        let item = "\(userID)/email"
        FirebaseManager.update(from: .users, item: item, value: email)
    }
    
    func update(password: String, with userID: Int) {
        let item = "\(userID)/password"
        FirebaseManager.update(from: .users, item: item, value: password)
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
    
    func getTopUsers(completion: @escaping AllUsersResponseBlock) {
        FirebaseManager.getValue(from: .users) { (response, error) in
            if let response = response {
                if let users = response as? NSArray {
                    var allUsers = [UserModel]()
                    for item in users {
                        if let selectedItem = item as? [String: Any] {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: selectedItem, options: .prettyPrinted)
                                let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                                allUsers.append(model)
                                
                            } catch {
                                completion(nil, error.localizedDescription)
                                return
                            }
                        }
                    }
                    let sortUsers = allUsers.sorted(by: { $0.score > $1.score })
                    let newUsers = sortUsers.enumerated().compactMap({ $0 < 11 ? $1 : nil })
                    completion(newUsers, nil)
                    return
                }
                completion(nil, "error_generic".localized)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
}
