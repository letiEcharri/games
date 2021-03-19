//
//  MainMenuCell.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class MainMenuCell: UICollectionViewCell {
    
    static var identifier: String {
        "MainMenuCell"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .stigo(style: .bold, size: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    func set(title: String) {
        backgroundColor = .purple
        layer.cornerRadius = 10
        
        titleLabel.text = title
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
