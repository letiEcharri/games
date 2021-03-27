//
//  NavigationBarProtocol.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import UIKit

protocol NavigationBarProtocol {
    func navigationBarButtons()
    func closeSession()
}

extension NavigationBarProtocol where Self: UIViewController {
    
    func navigationBarButtons() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let exit = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        navigationItem.rightBarButtonItem = exit
        
        exit.actionClosure = {
            self.closeSession()
        }
    }
}
