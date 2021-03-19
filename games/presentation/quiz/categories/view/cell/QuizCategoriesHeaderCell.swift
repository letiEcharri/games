//
//  QuizCategoriesHeaderCell.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCategoriesHeaderCell: UITableViewCell {

    static var identifier: String {
        "QuizCategoriesHeaderCell"
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .stigo(style: .bold, size: 20)
        label.textColor = .white
        
        return label
    }()
    
    lazy var circle: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        view.backgroundColor = .purple
        view.clipsToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemPink.cgColor
        view.addShadow()
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 80),
            view.heightAnchor.constraint(equalToConstant: 80),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    func set(title: String) {
        backgroundColor = .clear
        
        label.text = title
        addSubview(circle)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

}
