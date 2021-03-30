//
//  UserModel.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

enum UserCup {
    case gold
    case silver
    case bronze
}

struct UserModel: Codable {
    var id: Int
    var nick: String
    var score: Int
    var email: String
    
    func getColor() -> UIColor {
        switch getCUP() {
        case .bronze:
            return .bronze
        case .silver:
            return .silver
        case .gold:
            return .gold
        }
    }
    
    func getCUP() -> UserCup {
        switch score {
        case 101 ... 500:
            return .silver
        case 500...:
            return .gold
        default:
            return .bronze
        }
    }
    
    func getImage() -> UIImage? {
        if let userImage = UserDefaults.standard.object(forKey: UserDefaultsKeys.image.rawValue) as? Data {
            return UIImage(data: userImage)
        }
        return nil
    }
    
    func encode(with password: String) -> [String: Any] {
        
        var dictionary = (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
        dictionary["password"] = password
        
        return dictionary
    }
}

struct UsersModel: Decodable {
    let users: [UserModel]
}
