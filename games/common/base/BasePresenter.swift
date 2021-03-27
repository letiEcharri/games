//
//  BasePresenter.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class BasePresenter {
    
    func viewWillAppear() {
        
    }
        
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
}

protocol BasePresenterDelegate: class {
    func reloadData()
    func showLoading()
    func hideLoading()
    func showAlert(with viewModel: InfoAlertModel)
}
