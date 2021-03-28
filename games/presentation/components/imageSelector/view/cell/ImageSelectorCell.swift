//
//  ImageSelectorCell.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//

import UIKit

class ImageSelectorCell: UICollectionViewCell {
    
    static var identifier: String {
        "ImageSelectorCell"
    }
    
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFill
        
        return imageV
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false        
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        return view
    }()
    
    func set(image: UIImage) {
        imageView.image = image
        
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func selected(_ value: Bool) {
        container.layer.borderWidth = value ? 4 : 0
        container.layer.borderColor = UIColor.purple.cgColor
    }
}
