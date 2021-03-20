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
}
