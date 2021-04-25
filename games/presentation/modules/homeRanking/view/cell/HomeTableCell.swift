//
//  HomeTableCell.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    static var identifier: String {
        "HomeTableCell"
    }

    lazy var cupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .ic_cup
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return imageView
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 70)
        label.textColor = .black
        label.textAlignment = .center
                
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        
        stack.addArrangedSubview(cupImageView)
        stack.addArrangedSubview(scoreLabel)
                
        return stack
    }()
    
    func set(with model: UserModel) {
        backgroundColor = .clear
        
        scoreLabel.text = String(format: "%d", model.score)
        cupImageView.setImage(color: model.getColor())
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

}
