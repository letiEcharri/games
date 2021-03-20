//
//  FirebaseManager.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    static var ref: DatabaseReference = Database.database().reference()
    
    enum DataBase: String {
        case users
        case quiz
    }
    
    static func getValue(from database: DataBase, completion: @escaping (Any?, Error?) -> Void) {
        let search = database.rawValue
        FirebaseManager.ref.child(search).getData { (error, snapshot) in
            if let error = error {
                completion(nil, error)
            } else if snapshot.exists() {
                completion(snapshot.value, nil)
            } else {
                completion(nil, nil)
                print("No data available")
            }
        }
    }
    
    static func update(from database: DataBase, item: String, value: Any) {
        FirebaseManager.ref.child(database.rawValue).child(item).setValue(value) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
              print("Data could not be saved: \(error).")
            } else {
              print("Data saved successfully!")
            }
        }
    }
}
