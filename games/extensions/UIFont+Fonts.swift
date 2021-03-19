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
    
    public enum StigoStyle {
        case regular
        case italic
        case bold
        case boldItalic
    }
    
    public static func stigo(style: StigoStyle, size: CGFloat) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "StigoThinPERSONAL", size: size) ?? UIFont.systemFont(ofSize: size)
        case .italic:
            return UIFont(name: "StigoThinItalicPERSONAL", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont(name: "StigoREGPERSONAL", size: size) ?? UIFont.systemFont(ofSize: size)
        case .boldItalic:
            return UIFont(name: "StigoItalicPERSONAL", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
