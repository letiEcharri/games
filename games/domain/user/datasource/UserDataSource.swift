//
//  UserDataSource.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation
import Firebase

class UserDataSource: DataSource, UserDataSourceProtocol {
    
    static let shared: UserDataSourceProtocol = UserDataSource()
            
    // MARK: Functions
    
    func unlinkFirebaseAuth() {
        FirebaseManager.shared.unlinkFirebaseAuth()
    }
    
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock) {
        DispatchQueue.main.async {
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult,
                          let email = authResult.user.email {

                    let model = UserModel(id: authResult.user.uid, nick: self.getNick(from: email), score: 0, email: email)
                    completion(.success(model))
                } else {
                    let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock) {
        DispatchQueue.main.async {
            Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    
                } else if let authResult = authResult {
                    
                    completion(.success(authResult.user.uid))
                } else {
                    let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getUser(userID: String, completion: @escaping UserResponseBlock) {
        FirebaseManager.shared.getUser(userID: userID) { (response) in
            switch response {
            case .success(let data):
                if let data = data as? NSDictionary {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                        completion(.success(model))

                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    let code = data == nil ? Constants.Error.userNil.rawValue : 1
                    let error = NSError(domain:"", code: code, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock) {
        let user = [model.id: model.getDictionary()]
        FirebaseManager.shared.createItem(with: .users, value: model.getDictionary(), completion: completion)
    }
    
    func checkAuth(completion: @escaping (String?) -> Void) {
        FirebaseManager.shared.checkAuth(completion: completion)
    }
    
    func update(score: Int, with userID: Int) {
        let item = "\(userID)/score"
//        FirebaseManager.update(from: .users, item: item, value: score)
    }
    
    func update(email: String, with userID: Int) {
        let item = "\(userID)/email"
//        FirebaseManager.update(from: .users, item: item, value: email)
    }
    
    func update(password: String, with userID: Int) {
        let item = "\(userID)/password"
//        FirebaseManager.update(from: .users, item: item, value: password)
    }
    
    
    func getUserFromLocal(nick: String, completion: @escaping UserResponseBlock) {
        if let jsonData = readLocalFile(forName: "users") {
            do {
                let model = try JSONDecoder().decode(UsersModel.self, from: jsonData)
                if let user = model.users.first(where: { $0.nick == nick }) {
                    completion(.success(user))
                } else {
                    let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                    completion(.failure(error))
                }
                
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
            completion(.failure(error))
        }
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        FirebaseManager.shared.get(database: .users) { (response) in
            switch response {
            case .success(let data):
                if let data = data as? NSDictionary {
                    var users = [UserModel]()
                    for (_, value) in data {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                            let model = try JSONDecoder().decode(UserModel.self, from: jsonData)
                            users.append(model)

                        } catch {
                            completion(.failure(error))
                        }
                    }
                    let sortUsers = users.sorted(by: { $0.score > $1.score })
                    let newUsers = sortUsers.enumerated().compactMap({ $0 < 11 ? $1 : nil })
                    completion(.success(newUsers))
                } else {
                    let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    // MARK: Private functions
    
    private func getNick(from email: String) -> String {
        let groups = email.components(separatedBy: "@")
        return groups[0]
    }
    
}
