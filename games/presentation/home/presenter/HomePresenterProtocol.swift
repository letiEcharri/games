//
//  HomePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

protocol HomePresenterProtocol where Self: BasePresenter {
    
    var ui: HomePresenterDelegate? { get set }
    var user: UserModel? { get set }
    
    func play()
}

protocol HomePresenterDelegate: BasePresenterDelegate {
    func reloadData()
}
