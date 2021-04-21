//
//  FirebaseManager.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation
import Firebase

typealias FirebaseResponseBlock = (Result<Any?, Error>) -> Void

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let ref: DatabaseReference = Database.database().reference()
    private var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: DataBase
    
    enum DataBase: String {
        case users
        case quiz
    }
    
    func get(database: DataBase, completion: @escaping FirebaseResponseBlock) {
        ref.child(database.rawValue).observeSingleEvent(of: .value) { (snapshot) in
            completion(.success(snapshot.value))
        } withCancel: { (error) in
            completion(.failure(error))
        }
    }
    
    func getUser(userID: String, completion: @escaping FirebaseResponseBlock) {
        ref.child(DataBase.users.rawValue).child(userID).observeSingleEvent(of: .value) { (snapshot) in
            completion(.success(snapshot.value))
        } withCancel: { (error) in
            completion(.failure(error))
        }
    }
    
//    func update(from database: DataBase, item: String, value: Any) {
//        ref.child(database.rawValue).child(item).setValue(value) { (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//              print("Data could not be saved: \(error).")
//            } else {
//              print("Data saved successfully!")
//            }
//        }
//    }
    
    // MARK: Authorization
    
    func checkAuth(completion: @escaping (String?) -> Void) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                completion(user.uid)
            } else {
                completion(nil)
            }
        }
    }
    
    func unlinkFirebaseAuth() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
