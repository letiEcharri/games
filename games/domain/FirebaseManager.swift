//
//  FirebaseManager.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation
import Firebase

typealias FirebaseResponseBlock = (Result<Any?, Error>) -> Void
typealias FirebaseUpdateResponseBlock = (Error?) -> Void

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
        DispatchQueue.main.async {
            self.ref.child(database.rawValue).observeSingleEvent(of: .value) { (snapshot) in
                completion(.success(snapshot.value))
            } withCancel: { (error) in
                completion(.failure(error))
            }
        }
    }
    
    func getUser(userID: String, completion: @escaping FirebaseResponseBlock) {
        DispatchQueue.main.async {
            self.ref.child(DataBase.users.rawValue).child(userID).observeSingleEvent(of: .value) { (snapshot) in
                completion(.success(snapshot.value))
            } withCancel: { (error) in
                completion(.failure(error))
            }
        }
    }
    
    func update(_ database: DataBase, item: String, value: Any, completion: @escaping FirebaseUpdateResponseBlock) {
        DispatchQueue.main.async {
            self.ref.child(database.rawValue).child(item).setValue(value) { (error:Error?, ref:DatabaseReference) in
                if let error = error {
                  print("Data could not be saved: \(error).")
                } else {
                  print("Data saved successfully!")
                }
                completion(error)
            }
        }
    }
    
    func createItem(with database: DataBase, value: [String: Any], completion: @escaping FirebaseUpdateResponseBlock ) {
        DispatchQueue.main.async {
            guard let key = self.ref.child(database.rawValue).childByAutoId().key else { return }
            let keyValue = String(format: "/%@/%@", database.rawValue, key)
            self.ref.updateChildValues([keyValue: value]) { (error, databaseRef) in
                completion(error)
            }
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
        signOut()
        DispatchQueue.main.async {
            self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    completion(user.uid)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func unlinkFirebaseAuth() {
        DispatchQueue.main.async {
            if let handle = self.handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
    
    func signOut() {
        DispatchQueue.main.async {
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        }
    }
}
