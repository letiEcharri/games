//  
//  SplashPresenterProtocol.swift
//  games
//
//  Created by Leticia Personal on 23/04/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

// MARK: - ViewState

enum SplashSignal {
    case home(_ userID: String)
    case login
}

protocol SplashSignalDelegate: class {
    func signalTrigged(_ signal: SplashSignal)
}

protocol SplashPresenterProtocol where Self: BasePresenter {
    
    var ui: SplashPresenterDelegate? { get set }
    
}

protocol SplashPresenterDelegate: BasePresenterDelegate {
    
}
