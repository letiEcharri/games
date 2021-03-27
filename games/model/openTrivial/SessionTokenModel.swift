//
//  SessionTokenModel.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import Foundation

struct SessionTokenModel: Decodable {
    var responseCode: Int
    var responseMessage: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case responseMessage = "response_message"
        case token
    }
}
