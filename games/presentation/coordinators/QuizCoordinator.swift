//
//  QuizCoordinator.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies: QuizDependencies = AppDependencies()
    var childCoordinator: Coordinator?
    
    // MARK: - Init
        
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func resolve() {
        navigateToCategories()
    }
    
    // MARK: - HomeCoordinator Functions
    
    private func navigateToCategories() {
        let viewController = appDependencies.makeQuizCategoriesView(signaDelegate: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToQuestion(category: QuizCategoryModel) {
        let viewController = appDependencies.makeQuizQuestionView(signalDelegate: self, category: category)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension QuizCoordinator: QuizCategoriesSignalDelegate {
    func signalTrigged(_ signal: QuizCategoriesSignal) {
        switch signal {
        case .category(let cat):
            navigateToQuestion(category: cat)
        }
    }
}

extension QuizCoordinator: QuizQuestionSignalDelegate {
    func signalTrigged(_ signal: QuizQuestionSignal) {
        
    }
}
