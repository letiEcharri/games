//  
//  QuizScorePresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

protocol QuizScorePresenterProtocol where Self: BasePresenter {
    
    var ui: QuizScorePresenterDelegate? { get set }
    var score: Int { get }
    
    func exit()
}

protocol QuizScorePresenterDelegate: BasePresenterDelegate {
    
}
