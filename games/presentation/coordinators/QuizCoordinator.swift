//
//  QuizCoordinator.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var categoriesNavController: UINavigationController?
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
        categoriesNavController = UINavigationController(rootViewController: viewController)
        if let categoriesNavController = categoriesNavController {
            categoriesNavController.modalPresentationStyle = .fullScreen
            navigationController.present(categoriesNavController, animated: true)
        }
    }
    
    private func navigateToQuestion(category: QuizCategoryModel) {
        let viewController = appDependencies.makeQuizQuestionView(signalDelegate: self, category: category)
        categoriesNavController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToScore(model: QuizScorePresenter.Model) {
        let viewController = appDependencies.makeQuizScoreView(signalDelegate: self, model: model)
        categoriesNavController?.pushViewController(viewController, animated: true)
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
        switch signal {
        case .score(let model):
            navigateToScore(model: model)
        case .finish:
            categoriesNavController?.dismiss(animated: true)
        }
    }
}
