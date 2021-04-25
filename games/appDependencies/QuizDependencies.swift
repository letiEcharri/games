//
//  QuizDependencies.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

protocol QuizDependencies {
    func makeQuizCategoriesView(signaDelegate: QuizCategoriesSignalDelegate) -> QuizCategoriesViewController
    func makeQuizQuestionView(signalDelegate: QuizQuestionSignalDelegate, category: QuizCategoryModel) -> QuizQuestionViewController
    func makeQuizScoreView(signalDelegate: QuizQuestionSignalDelegate, model: QuizScorePresenter.Model) -> QuizScoreViewController
}

extension AppDependencies: QuizDependencies {
    func makeQuizCategoriesView(signaDelegate: QuizCategoriesSignalDelegate) -> QuizCategoriesViewController {
        
        let presenter = QuizCategoriesPresenter(signalDelegate: signaDelegate)
        let viewController = QuizCategoriesViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
    
    func makeQuizQuestionView(signalDelegate: QuizQuestionSignalDelegate, category: QuizCategoryModel) -> QuizQuestionViewController {
        
        let presenter = QuizQuestionPresenter(signalDelegate: signalDelegate, category: category)
        let viewController = QuizQuestionViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
    
    func makeQuizScoreView(signalDelegate: QuizQuestionSignalDelegate, model: QuizScorePresenter.Model) -> QuizScoreViewController {
        
        let presenter = QuizScorePresenter(signalDelegate: signalDelegate, model: model)
        let viewController = QuizScoreViewController(presenter)
        
        presenter.ui = viewController
        
        return viewController
    }
}
