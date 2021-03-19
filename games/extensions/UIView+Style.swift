//
//  UIView+Style.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 1.0
        self.clipsToBounds = false
    }
}
