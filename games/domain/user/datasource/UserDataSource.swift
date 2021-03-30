//
//  UserDataSource.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class UserDataSource: DataSource, UserDataSourceProtocol {
    
    static let shared: UserDataSourceProtocol = UserDataSource()
    
    func getUser(with id: Int, completion: @escaping UserResponseBlock) {
        FirebaseManager.getValue(from: .users, itemID: id) { (response, error) in
            if let response = response {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                    completion(model, nil)
                    return
                } catch {
                    completion(nil, error.localizedDescription)
                    return
                }
            } else if let error = error {
                completion(nil, error.localizedDescription)
            }
            completion(nil, "error_generic".localized)
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
        
        FirebaseManager.getAllItems(from: .users) { (response, error) in
            if let response = response {
                
                if let users = response as? [String: Any] {
                    for (_, item) in users {
                        
                        if let fireItem = item as? [String: Any],
                           let fireUser = fireItem["nick"] as? String,
                           let firePass = fireItem["password"] as? String,
                           fireUser == user {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                                let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                                
                                completion(firePass == pass, model, nil)
                                return

                            } catch {
                                completion(false, nil, error)
                                return
                            }
                        }
                        
                    }
                    
                }
                
            } else if let error = error {
                completion(false, nil, error)
                return
            }
            
            let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
            completion(false, nil, error)
        }
        
    }
    
    func getUserFromLocal(nick: String, completion: @escaping UserResponseBlock) {
        if let jsonData = readLocalFile(forName: "users") {
            do {
                let model = try JSONDecoder().decode(UsersModel.self, from: jsonData)
                let user = model.users.first(where: { $0.nick == nick })
                completion(user, nil)
                
            } catch {
                completion(nil, error.localizedDescription)
            }
        } else {
            completion(nil, "error_generic".localized)
        }
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        FirebaseManager.getAllItems(from: .users) { (response, error) in
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
    
    func singUp(user: UserModel, password: String, completion: @escaping ResponseBlock) {
        let dictionary = user.encode(with: password)
        FirebaseManager.add(item: dictionary, to: .users, completion: completion)
    }
    
}
