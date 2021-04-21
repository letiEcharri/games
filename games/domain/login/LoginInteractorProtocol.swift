//  
//  LoginInteractorProtocol.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import Foundation

protocol LoginInteractorProtocol {
    func unlinkFirebaseAuth()
    func signUp(email: String, pass: String, completion: @escaping SignUpResponseBlock)
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
}
