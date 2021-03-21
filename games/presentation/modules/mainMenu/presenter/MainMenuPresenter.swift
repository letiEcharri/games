//
//  MainMenuPresenter.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

class MainMenuPresenter: BasePresenter, MainMenuPresenterProtocol {
    
    struct Model {
        let title: String
        let signal: MainMenuSignal
    }
    
    // MARK: - Properties
    
    var ui: MainMenuPresenterDelegate?
    var sections: [Model] = []
    
    private var signalDelegate: MainMenuSignalDelegate
    
    // MARK: - Initialization
    
    init(signalDelegate: MainMenuSignalDelegate) {
        self.signalDelegate = signalDelegate
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear() {
        getSections()
        self.ui?.reloadData()
    }
    
    // MARK: - Presenter Functions
    
    func didSelectSection(with row: Int) {
        let section = sections[row]
        signalDelegate.signalTrigged(section.signal)
    }
    
    // MARK: - Private Functions
    
    private func getSections() {
        let quiz = Model(title: "Quiz", signal: .quiz)
        let dayQuestion = Model(title: "Reto del día", signal: .dayQuestion)
        sections = [quiz, dayQuestion]
    }
}
