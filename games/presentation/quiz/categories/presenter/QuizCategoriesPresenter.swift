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
    var categories: [QuizCategoryModel] = []
    
    private var signalDelegate: QuizCategoriesSignalDelegate
    
    // MARK: - Initialization
    
    init(signalDelegate: QuizCategoriesSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - Presenter Functions
    
    override func viewWillAppear() {
        interactor.getQuizCategories { (cats, error) in
            if let cats = cats {
                self.categories = cats
                self.ui?.reloadData()
            }
        }
    }
}
