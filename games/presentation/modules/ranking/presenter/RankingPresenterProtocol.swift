//  
//  RankingPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

protocol RankingPresenterProtocol where Self: BasePresenter {
    
    var ui: RankingPresenterDelegate? { get set }
    var users: [UserModel]? { get }
}

protocol RankingPresenterDelegate: BasePresenterDelegate {
    
}
