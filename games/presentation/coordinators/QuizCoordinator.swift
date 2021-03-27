//
//  QuizCoordinator.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let appDependencies = AppDependencies()
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
    
    private func navigateToScore(model: QuizScorePresenter.Model) {
        let viewController = appDependencies.makeQuizScoreView(signalDelegate: self, model: model)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToMainMenu() {
        childCoordinator = MainMenuCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateToHome() {
        childCoordinator = HomeCoordinator(navigationController)
        childCoordinator?.resolve()
    }
    
    private func navigateToUserProfile() {
        let viewController = appDependencies.makeUserProfileView()
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension QuizCoordinator: QuizCategoriesSignalDelegate {
    func signalTrigged(_ signal: QuizCategoriesSignal) {
        switch signal {
        case .category(let cat):
            navigateToQuestion(category: cat)
        case .home:
            navigateToHome()
        case .profile:
            navigateToUserProfile()
        }
    }
}

extension QuizCoordinator: QuizQuestionSignalDelegate {
    func signalTrigged(_ signal: QuizQuestionSignal) {
        switch signal {
        case .score(let model):
            navigateToScore(model: model)
        case .finish:
            navigateToMainMenu()
        }
    }
}
