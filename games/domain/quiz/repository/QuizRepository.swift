//
//  QuizRepository.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizRepository: QuizRepositoryProtocol {
    
    static let shared: QuizRepositoryProtocol = QuizRepository()
    
    let session = SessionQuizDataSource.shared
    let datasource: QuizDataSourceProtocol = QuizDataSource.shared
    
    func getQuizCategories(completion: @escaping QuizCategoriesResponseBlock) {
        if let quiz = session.quiz {
            completion(quiz.categories, nil)
        } else {
            datasource.getQuiz { (model, error) in
                if let model = model {
                    self.session.quiz = model
                    completion(model.categories, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
}
