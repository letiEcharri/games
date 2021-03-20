//
//  QuizQuestionPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

enum QuizQuestionSignal {
    case score(_ model: QuizScorePresenter.Model)
    case finish
}

protocol QuizQuestionSignalDelegate: class {
    func signalTrigged(_ signal: QuizQuestionSignal)
}

protocol QuizQuestionPresenterProtocol where Self: BasePresenter {
    var ui: QuizQuestionPresenterDelegate? { get set }
    var category: QuizCategoryModel { get set }
    var question: QuizQuestionModel { get }
    
    func next(selected answer: String)
    func isAnswerRight(with key: String) -> Bool
    func getStepsModel() -> ProgressStepBar.Model
}

protocol QuizQuestionPresenterDelegate: BasePresenterDelegate {
    
}
