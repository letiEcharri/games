//  
//  QuizScorePresenter.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class QuizScorePresenter: BasePresenter, QuizScorePresenterProtocol {
    
    struct Model {
        let totalQuestions: Int
        let rightQuestions: Int
    }
    
    // MARK: - Properties
    
    private weak var signalDelegate: QuizQuestionSignalDelegate?
    private let interactor: UserInteractorProtocol = UserInteractor.shared
    
    weak var ui: QuizScorePresenterDelegate?
    
    private var model: Model
    
    var score: Int {
        model.rightQuestions
    }
    
    // MARK: - Initialization
    
    init(signalDelegate: QuizQuestionSignalDelegate, model: Model) {
        self.signalDelegate = signalDelegate
        self.model = model
    }
    
    // MARK: - QuizScorePresenter Functions
    
    func exit() {
        interactor.update(score: score)
        signalDelegate?.signalTrigged(.finish)
    }
}
