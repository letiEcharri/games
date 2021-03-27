//  
//  UserProfilePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

protocol UserProfilePresenterProtocol where Self: BasePresenter {
    
    var ui: UserProfilePresenterDelegate? { get set }
    var user: UserModel? { get }
    
    func textfieldAction(isSecureEntry: Bool, text: String)
}

protocol UserProfilePresenterDelegate: BasePresenterDelegate {
    
}
