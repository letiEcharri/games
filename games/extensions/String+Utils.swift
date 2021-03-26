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
}
