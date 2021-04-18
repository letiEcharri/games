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
    
    static var ic_games_backgroung: UIImage = {
        if let image = UIImage(named: "ic_games_backgroung") {
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
    
    static var ic_back: UIImage = {
        if let image = UIImage(named: "ic_back") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_toolbar_cup: UIImage = {
        if let image = UIImage(named: "ic_toolbar_cup") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_toolbar_play: UIImage = {
        if let image = UIImage(named: "ic_toolbar_play") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_toolbar_user: UIImage = {
        if let image = UIImage(named: "ic_toolbar_user") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_exit: UIImage = {
        if let image = UIImage(named: "ic_exit") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_warning: UIImage = {
        if let image = UIImage(named: "ic_warning") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_black_woman: UIImage = {
        if let image = UIImage(named: "ic_black_woman") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_blond_woman: UIImage = {
        if let image = UIImage(named: "ic_blond_woman") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_emo_worker: UIImage = {
        if let image = UIImage(named: "ic_emo_worker") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_happy_man: UIImage = {
        if let image = UIImage(named: "ic_happy_man") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_ponytail_woman: UIImage = {
        if let image = UIImage(named: "ic_ponytail_woman") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_white_woman: UIImage = {
        if let image = UIImage(named: "ic_white_woman") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_woman_orange: UIImage = {
        if let image = UIImage(named: "ic_woman_orange") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_worker: UIImage = {
        if let image = UIImage(named: "ic_worker") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_victor: UIImage = {
        if let image = UIImage(named: "ic_victor") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_hipster: UIImage = {
        if let image = UIImage(named: "ic_hipster") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_man_beard: UIImage = {
        if let image = UIImage(named: "ic_man_beard") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_modern_woman: UIImage = {
        if let image = UIImage(named: "ic_modern_woman") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_man_beard_blond: UIImage = {
        if let image = UIImage(named: "ic_man_beard_blond") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_woman_glasses: UIImage = {
        if let image = UIImage(named: "ic_woman_glasses") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_generic_user: UIImage = {
        if let image = UIImage(named: "ic_generic_user") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_edit: UIImage = {
        if let image = UIImage(named: "ic_edit") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_black_man: UIImage = {
        if let image = UIImage(named: "ic_black_man") {
            return image
        }
        return UIImage()
    }()
    
    static var ic_email: UIImage = {
        if let image = UIImage(named: "ic_email") {
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
