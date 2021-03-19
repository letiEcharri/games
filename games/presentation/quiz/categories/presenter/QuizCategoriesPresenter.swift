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
    
    var ui: QuizCategoriesPresenterDelegate?
    var categories: [QuizCategoryModel] = []
    
    private var signalDelegate: QuizCategoriesSignalDelegate
    
    // MARK: - Initialization
    
    init(signalDelegate: QuizCategoriesSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - Presenter Functions
    
    override func viewWillAppear() {
        getCategories()
    }
    
    // MARK: - Private Functions
    
    private func getCategories() {
        // TODO: Get categorias from service
        let quiz = readLocalFile(forName: "quiz")
        let decoder = JSONDecoder()
                    
        do {
            if let quizData = quiz {
                let model = try decoder.decode(QuizModel.self, from: quizData)
                self.categories = model.quiz.categories
                self.ui?.reloadData()
            }
            
        } catch {
            print(error)
        }
        
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
