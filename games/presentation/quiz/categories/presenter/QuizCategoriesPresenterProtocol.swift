//
//  QuizCategoriesPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

enum QuizCategoriesSignal {
}

protocol QuizCategoriesSignalDelegate: class {
    func signalTrigged(_ signal: QuizCategoriesSignal)
}

protocol QuizCategoriesPresenterProtocol where Self: BasePresenter {
    var ui: QuizCategoriesPresenterDelegate? { get set }
    var categories: [QuizCategoryModel] { get set }
}

protocol QuizCategoriesPresenterDelegate: BasePresenterDelegate {
    
}
