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
    
    static var ic_background: UIImage = {
        if let image = UIImage(named: "ic_background") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_tick: UIImage = {
        if let image = UIImage(named: "ic_tick") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_cross: UIImage = {
        if let image = UIImage(named: "ic_cross") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_lock: UIImage = {
        if let image = UIImage(named: "ic_lock") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_user: UIImage = {
        if let image = UIImage(named: "ic_user") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_eye: UIImage = {
        if let image = UIImage(named: "ic_eye") {
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
