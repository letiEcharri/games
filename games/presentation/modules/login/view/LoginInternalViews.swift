//
//  LoginInternalViews.swift
//  games
//
//  Created by Leticia Personal on 29/03/2021.
//

import UIKit

extension LoginViewController {
    
    // MARK: SideView
    
    class SideView: UIView {
        
        enum Side {
            case left
            case right
        }
        
        // Views
        
        lazy var backgroundImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleToFill
            imageView.layer.cornerRadius = 30
            imageView.clipsToBounds = true
            
            return imageView
        }()
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .bandar(style: .regular, size: 20)
            label.textColor = .purple
            label.text = title
            
            return label
        }()
        
        // Properties
        
        private var title: String
        var selected: Bool = false {
            didSet {
                setStyle()
            }
        }
        var side: Side
        
        // Initialization
        
        init(title: String, side: Side) {
            self.title = title
            self.side = side
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Functions
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            clipsToBounds = true
            backgroundColor = .clear
            layer.cornerRadius = 30
            
            addSubview(backgroundImage)
            NSLayoutConstraint.activate([
                backgroundImage.topAnchor.constraint(equalTo: topAnchor),
                backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
                backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
                        
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        
        private func setStyle() {
            if selected {
                addShadow()
                backgroundImage.image = side == .left ? .leftBackground : .rightBackground
                titleLabel.textColor = .white
            } else {
                layer.shadowOpacity = 0
                backgroundImage.image = nil
                titleLabel.textColor = .purple
            }
        }
    }
    
    // MARK: SideView
    
    class TextField: UITextField {
        
        lazy var rightImage: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
            imageView.contentMode = .scaleAspectFit
            
            let rightImageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
            rightImageContainerView.addSubview(imageView)
            rightView = rightImageContainerView
            rightViewMode = .always
            
            return imageView
        }()
        
        override var placeholder: String? {
            didSet {
                setPlaceholderStyle()
            }
        }
        
        // Initialization
        
        init(text: String, image: UIImage) {
            super.init(frame: .zero)
            self.placeholder = text
            self.rightImage.image = image
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            addBorder(.bottom, color: .purple, thickness: 2)
            rightImage.setImage(color: .purple)
            font = .bandar(style: .regular, size: 25)
            textColor = .purple
            tintColor = .purple
            
            heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        private func setPlaceholderStyle() {
            let attributtes = [
                NSAttributedString.Key.foregroundColor: UIColor.purple.withAlphaComponent(0.5),
                NSAttributedString.Key.font: UIFont.bandar(style: .italic, size: 20)
            ]
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributtes)
        }
    }
}
