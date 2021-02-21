//
//  HomeViewController.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    let presenter: HomePresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup UI
    
    override func loadStyle() {
        self.view.backgroundColor = .white
    }
    
    override func setTexts() {
        self.title = "HOME"
    }
    
    // MARK: - Functions

}

// MARK: Presenter Delegate

extension HomeViewController: HomePresenterDelegate {
    
}
