//
//  UserRepository.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation

class UserRepository: UserRepositoryProtocol {
    
    static let shared: UserRepositoryProtocol = UserRepository()
    
    let session = SessionUserDataSource.shared
    let datasource: UserDataSourceProtocol = UserDataSource.shared
    
    func unlinkFirebaseAuth() {
        datasource.unlinkFirebaseAuth()
    }
    
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock) {
        datasource.signUp(email: email, pass: pass) { (response) in
            switch response {
            case .success(let user):
                self.session.user = user
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock) {
        datasource.signIn(email: email, pass: pass, completion: completion)
    }
    
    func signOut() {
        SessionDataSource.closeSession()
        datasource.signOut()
    }
    
    func getUser(completion: @escaping UserResponseBlock) {
        if let sessionUser = self.session.user {
            completion(.success(sessionUser))
        } else {
            
            datasource.getUser { (response) in
                switch response {
                case .success(let user):
                    self.session.user = user
                    completion(.success(user))
                    
                case .failure(let error):
                    self.signOut()
                    completion(.failure(error))
                }
            }
        }
    }
    
    func createUser(with model: UserModel, completion: @escaping FirebaseUpdateResponseBlock) {
        var user = model
        user.nick = getNick(from: model.email)
        
        datasource.createUser(with: user) { (error) in
            if error == nil {
                self.session.user = user
            }
            completion(error)
        }
    }
    
    func checkAuth(completion: @escaping (String?) -> Void) {
        datasource.checkAuth(completion: completion)
    }
    
    func editUser(field: UserDataSource.Edit, value: Any, completion: @escaping FirebaseUpdateResponseBlock) {
        getUser { (response) in
            switch response {
            case .success(let user):
                self.datasource.editUser(field: field, with: user.id, value: value) { (error) in
                    if error == nil {
                        switch field {
                        case .nick:
                            if let nick = value as? String {
                                self.session.user?.nick = nick
                            }
                        case .score:
                            if let score = value as? Int {
                                self.session.user?.score = score
                            }
                        case .image:
                            if let image = value as? String {
                                self.session.user?.image = image
                            }
                        default:
                            break
                        }
                    }
                    completion(error)
                }
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getTopUsers(completion: @escaping TopUsersResponseBlock) {
        datasource.getTopUsers(completion: completion)
    }
    
    // MARK: Private functions
    
    private func getNick(from email: String) -> String {
        let groups = email.components(separatedBy: "@")
        return groups[0]
    }
}
