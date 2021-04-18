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
    func login(user: String, pass: String, completion: @escaping LoginRepositoryBlock)
    func checkAuth(completion: @escaping FirebaseAuthBlock)
    func unlinkFirebaseAuth()
    func signUp(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
    func signIn(email: String, pass: String, completion: @escaping SignLoginResponseBlock)
}
