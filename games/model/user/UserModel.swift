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
    var id: Int
    var nick: String
    var score: Int
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
