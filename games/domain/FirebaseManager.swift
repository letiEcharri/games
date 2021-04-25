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
    
    func getUser(completion: @escaping FirebaseResponseBlock) {
        checkAuth { (userID) in
            if let userID = userID {
                self.ref.child(DataBase.users.rawValue).child(userID).observeSingleEvent(of: .value) { (snapshot) in
                    completion(.success(snapshot.value))
                } withCancel: { (error) in
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain:"", code: 1, userInfo: [NSLocalizedDescriptionKey: "error_generic".localized]) as Error
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
    
    func update(password: String, completion: @escaping FirebaseUpdateResponseBlock) {
        DispatchQueue.main.async {
            let user = Auth.auth().currentUser
            
            user?.updatePassword(to: password, completion: { (error) in
                completion(error)
            })
        }
    }
    
    // MARK: Authorization
    
    func checkAuth(completion: @escaping (String?) -> Void) {
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
