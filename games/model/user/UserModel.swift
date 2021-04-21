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

struct UserModel: Decodable {
    var id: String
    var nick: String
    var score: Int
    var email: String
    
    var cup: UserCup {
        switch score {
        case 101 ... 500:
            return .silver
        case 500...:
            return .gold
        default:
            return .bronze
        }
    }
    
    var image: UIImage? {
        if let userImage = UserDefaults.standard.object(forKey: UserDefaultsKeys.image.rawValue) as? Data {
            return UIImage(data: userImage)
        }
        return nil
    }
    
    func getColor() -> UIColor {
        switch cup {
        case .bronze:
            return .bronze
        case .silver:
            return .silver
        case .gold:
            return .gold
        }
    }
}

struct UsersModel: Decodable {
    let users: [UserModel]
}
