//
//  HomePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import Foundation

protocol HomePresenterProtocol where Self: BasePresenter {
    
    var ui: HomePresenterDelegate? { get set }
}

protocol HomePresenterDelegate: BasePresenterDelegate {
    
}
