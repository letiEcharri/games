//
//  QuizCategoriesPresenter.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class QuizCategoriesPresenter: BasePresenter, QuizCategoriesPresenterProtocol {
    
    struct Model {
        let title: String
    }
    
    // MARK: - Properties
    
    private let interactor: QuizInteractorProtocol = QuizInteractor.shared
    
    var ui: QuizCategoriesPresenterDelegate?
    var categories: [QuestionCategory] = QuestionCategory.allCases
    
    private var signalDelegate: QuizCategoriesSignalDelegate
    
    // MARK: - Initialization
    
    init(signalDelegate: QuizCategoriesSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - Presenter Functions
    
    func didSelect(with row: Int) {
        var model = OpenTrivialRequestModel()
        if row != 0 {
            model.category = categories[row-1]
        }
        interactor.getQuestions(with: model) { (category, error) in
            if let category = category {
                self.signalDelegate.signalTrigged(.category(category))
            } else if let error = error {
                let viewModel = InfoAlertModel(type: .error, description: error.localizedDescription)
                self.ui?.showAlert(with: viewModel)
            }
        }
    }
    
    func goToHome() {
        signalDelegate.signalTrigged(.home)
    }
    
    func goToProfile() {
        signalDelegate.signalTrigged(.profile)
    }
}
