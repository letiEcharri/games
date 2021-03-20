//
//  QuizDataSourceProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

typealias QuizResponseBlock = (QuizCategoriesModel?, Error?) -> Void

protocol QuizDataSourceProtocol {
    func getQuiz(completion: @escaping QuizResponseBlock)
}
