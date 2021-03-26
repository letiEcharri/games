//
//  QuizDataSourceProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

typealias QuizResponseBlock = (QuizCategoriesModel?, Error?) -> Void
typealias QuizCategoryResponseBlock = (QuizCategoryModel?, Error?) -> Void

protocol QuizDataSourceProtocol: OpenTrivialDataBase {
    func getQuiz(completion: @escaping QuizResponseBlock)
    func getQuestions(with model: OpenTrivialRequestModel, completion: @escaping QuizCategoryResponseBlock)
}
