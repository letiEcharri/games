//
//  String+Utils.swift
//  games
//
//  Created by Leticia Personal on 26/03/2021.
//

import Foundation

extension String {
    
    var localized: String {
        get {
            NSLocalizedString(self, comment: "")
        }
    }
    
    var utfData: Data {
        return Data(utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        
        do {
            return try NSAttributedString(data: utfData, options: [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
    
    func formatted() -> String {
        if let attString = attributedHtmlString {
            return attString.string
        }
        return self
    }
}
