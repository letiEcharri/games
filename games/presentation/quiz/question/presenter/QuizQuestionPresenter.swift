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
    var rightAnswers: [Int] = []
    
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
        if question.answer == answer {
            rightAnswers.append(index+1)
            score += 1
        }
        if index < (category.questions.count - 1) {
            index += 1
            self.ui?.reloadData()
        } else if index == (category.questions.count - 1) {
            let model = QuizScorePresenter.Model(totalQuestions: category.questions.count, rightQuestions: score)
            signalDelegate.signalTrigged(.score(model))
        }
    }
    
    func isAnswerRight(with key: String) -> Bool {
        return question.answer == key
    }
    
    func getStepsModel() -> ProgressStepBar.Model {
        return ProgressStepBar.Model(steps: category.questions.count, currentStep: index + 1, rightSteps: rightAnswers)
    }
}
