//
//  QuizInteractor.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizInteractor: QuizInteractorProtocol {
    
    static let shared: QuizInteractorProtocol = QuizInteractor()
    
    let repository: QuizRepositoryProtocol = QuizRepository.shared
    
    func getQuizCategories(completion: @escaping QuizCategoriesResponseBlock) {
        repository.getQuizCategories(completion: completion)
    }
}
