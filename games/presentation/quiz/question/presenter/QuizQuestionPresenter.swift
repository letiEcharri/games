//
//  QuizQuestionPresenter.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizQuestionPresenter: BasePresenter, QuizQuestionPresenterProtocol {
    
    // MARK: - Properties
    
    private let signalDelegate: QuizQuestionSignalDelegate
    
    var ui: QuizQuestionPresenterDelegate?
    var category: QuizCategoryModel
    var question: QuizQuestionModel {
        category.questions[index]
    }
    var index = 0
    var score = 0
    
    // MARK: - Initialization
    
    init(signalDelegate: QuizQuestionSignalDelegate, category: QuizCategoryModel) {
        self.signalDelegate = signalDelegate
        self.category = category
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        self.ui?.reloadData()
    }
    
    // MARK: - Presenter Functions
    
    func next(selected answer: String) {
        if index < (category.questions.count - 1) {
            index += 1
            score += question.answer == answer ? 1 : 0
            self.ui?.reloadData()
        }
    }
    
    func isAnswerRight(with key: String) -> Bool {
        return question.answer == key
    }
}
