//
//  HomeRankingCell.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//

import UIKit

class HomeRankingCell: UITableViewCell {

    struct Model {
        var left: String
        var center: String
        var right: String
        var header: Bool
    }

    static var identifier: String {
        "RankingCell"
    }
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .bandar(style: .regular, size: 20)
        label.textColor = .purple
        
        return label
    }()
    
    lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .bandar(style: .regular, size: 20)
        label.textColor = .purple
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .bandar(style: .regular, size: 20)
        label.textColor = .purple
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            leftLabel,
            centerLabel,
            rightLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    func set(with model: Model) {
        backgroundColor = .clear
        leftLabel.text = model.left
        centerLabel.text = model.center
        rightLabel.text = model.right
        
        if model.header {
            leftLabel.font = .bandar(style: .bold, size: 20)
            centerLabel.font = .bandar(style: .bold, size: 20)
            rightLabel.font = .bandar(style: .bold, size: 20)
        }
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
