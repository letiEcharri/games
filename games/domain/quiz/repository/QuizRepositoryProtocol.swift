//
//  QuizRepositoryProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

typealias QuizCategoriesResponseBlock = ([QuizCategoryModel]?, Error?) -> Void

protocol QuizRepositoryProtocol {
    func getQuizCategories(completion: @escaping QuizCategoriesResponseBlock)
    func getQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuizCategoryResponseBlock)
}
