//
//  NavToolbarProtocol.swift
//  games
//
//  Created by Leticia Personal on 23/03/2021.
//

import UIKit

protocol NavToolbarProtocol: class {
    func configureToolbar()
    
    func toolbarPlayAction()
    func toolbarHomeAction()
    func toolbarProfileAction()
}

extension NavToolbarProtocol where Self: UIViewController {
    func configureToolbar() {
        navigationController?.toolbar.backgroundColor = .purple
        navigationController?.toolbar.barTintColor = .purple
        navigationController?.toolbar.tintColor = .white
        navigationController?.setToolbarHidden(false, animated: true)
        
        setToolbarItems(getToolbarItems(), animated: true)
    }
    
    private func getToolbarItems() -> [UIBarButtonItem] {
        
        let play = UIBarButtonItem(image: .ic_toolbar_play, style: .plain, target: nil, action: nil)
        let home = UIBarButtonItem(image: .ic_toolbar_cup, style: .plain, target: nil, action: nil)
        let profile = UIBarButtonItem(image: .ic_toolbar_user, style: .plain, target: nil, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        
        play.actionClosure = {
            self.toolbarPlayAction()
        }
        
        home.actionClosure = {
            self.toolbarHomeAction()
        }
        
        profile.actionClosure = {
            self.toolbarProfileAction()
        }
        
        return [play, spacer, home, spacer, profile]
    }
}
