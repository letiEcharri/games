//
//  UIImage+Images.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

extension UIImage {
    
    static var ic_cup: UIImage =  {
        if let image = UIImage(named: "ic_cup") {
            return image
        }
        return UIImage()
    }()
}

extension UIImageView {
    
    func setImage(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
