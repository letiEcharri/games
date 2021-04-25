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
    
    func getQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuizCategoryResponseBlock) {
        var newModel = model
        if let sessionToken = session.token {
            newModel.token = sessionToken
            datasource.getQuestions(with: newModel, completion: completion)
        } else {
            retrieveToken { (success, error) in
                if success {
                    newModel.token = self.session.token
                    self.datasource.getQuestions(with: newModel, completion: completion)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    private func retrieveToken(completion: @escaping (Bool, Error?) -> Void) {
        datasource.retrieveSessionToken { (token, error) in
            if let token = token {
                self.session.token = token
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
