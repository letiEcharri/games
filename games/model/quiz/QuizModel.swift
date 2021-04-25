//
//  QuizModel.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

struct QuizModel: Decodable {
    let quiz: QuizCategoriesModel
}

struct QuizCategoriesModel: Decodable {
    let categories: [QuizCategoryModel]
}

struct QuizCategoryModel: Decodable {
    let name: String
    let questions: [QuizQuestionModel]
}

struct QuizQuestionModel: Decodable {
    let id: Int
    let question: String
    let answers: QuizCategoryAnswersModel
    let answer: String
}

struct QuizCategoryAnswersModel: Decodable {
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    
    func getRight(answer: String) -> String {
        switch answer {
        case answer1:
            return "answer1"
        case answer2:
            return "answer2"
        case answer3:
            return "answer3"
        case answer4:
            return "answer4"
        default:
            return "answer1"
        }
    }
}
