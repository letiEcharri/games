//
//  SessionQuizDataSource.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class SessionQuizDataSource {
    
    static let shared = SessionQuizDataSource()
    
    var quiz: QuizCategoriesModel?
    
    func clear() {
        quiz = nil
    }
}
