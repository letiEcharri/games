//
//  UIFont+Fonts.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

extension UIFont {
    
    // MARK: Panton
    
    public enum PantonStyle {
        case regular
        case italic
        case bold
        case boldItalic
    }
    
    public static func panton(style: PantonStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "PantonDemo-Light", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont(name: "PantonDemo-Black", size: size) ?? UIFont.systemFont(ofSize: size)
        case .boldItalic:
            return UIFont(name: "PantonDemo-BlackItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont(name: "PantonDemo-LightItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    // MARK: Stigo
    
    public enum BandarStyle {
        case regular
        case italic
        case bold
        case boldItalic
        case outline
    }
    
    public static func bandar(style: BandarStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "BandarRegular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont(name: "BandarItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont(name: "BandarBold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .boldItalic:
            return UIFont(name: "BandarBoldItalic", size: size) ?? UIFont.systemFont(ofSize: size)
        case .outline:
            return UIFont(name: "BandarOutline", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
