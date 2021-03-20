//
//  QuizCategoriesCell.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCategoriesCell: UITableViewCell {
    
    static var identifier: String {
        "QuizCategoriesCell"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 20)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var boxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        view.layer.cornerRadius = 10
        view.addShadow()
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    func set(title: String) {
        backgroundColor = .clear
        clipsToBounds = false
        selectionStyle = .none
        
        titleLabel.text = title
        
        self.addSubview(boxView)
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            boxView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            boxView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boxView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
