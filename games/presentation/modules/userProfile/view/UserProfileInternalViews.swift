//
//  UserProfileInternalViews.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//

import UIKit

extension UserProfileViewController {
    
    // MARK: - TextField
    
    class TextField: UITextField {
        
        lazy var rightImage: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 5, y: 15, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = .ic_edit
            imageView.setImage(color: .purple)
            imageView.isUserInteractionEnabled = true
            
            return imageView
        }()
        
        override var isSecureTextEntry: Bool {
            didSet {
                if isSecureTextEntry {
                    font = .bandar(style: .regular, size: 50)
                }
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            backgroundColor = .clear
            translatesAutoresizingMaskIntoConstraints = false
            font = .bandar(style: .regular, size: 22)
            textColor = .black
            isEnabled = false
            textAlignment = .center
            tintColor = .purple

            heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        func disable() {
            isEnabled = false
            borderStyle = .none
            backgroundColor = .clear
            resignFirstResponder()
        }
    }
    
    // MARK: - TexFieldView
    
    class TexFieldView: UIView {
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .bandar(style: .boldItalic, size: 18)
            label.textColor = .black
            label.textAlignment = .center
            
            return label
        }()
        
        lazy var rightImage: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.image = .ic_edit
            imageView.setImage(color: .purple)
            imageView.isUserInteractionEnabled = true
            
            imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(editTapAction(_:)))
            imageView.addGestureRecognizer(tap)
            
            return imageView
        }()
        
        lazy var txtStackView: UIStackView =  {
            let stack = UIStackView(arrangedSubviews: [
                textField,
                rightImage
            ])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.spacing = 5
            
            stack.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            return stack
        }()
        
        lazy var stackView: UIStackView =  {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            
            return stack
        }()
        
        var isSecureTextEntry: Bool = false
        private var text: String
        var textField = TextField()
        var customFont: UIFont?
        
        var delegate: ChangePassViewProtocol?
        
        init(text: String, isSecureTextEntry: Bool, font: UIFont? = nil) {
            self.text = text
            self.isSecureTextEntry = isSecureTextEntry
            self.customFont = font
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            backgroundColor = .clear
            
            heightAnchor.constraint(equalToConstant: 70).isActive = true
        
            titleLabel.text = isSecureTextEntry ? "password".localized : ""
            textField.isSecureTextEntry = isSecureTextEntry
            textField.text = text
            if let font = customFont {
                textField.font = font
            }
            
            if isSecureTextEntry {
                stackView.addArrangedSubview(titleLabel)
            }
            stackView.addArrangedSubview(txtStackView)
            
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
        
        @objc private func editTapAction(_ sender: UITapGestureRecognizer) {
            textField.isEnabled = true
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            if isSecureTextEntry {
                textField.text = ""
            }
            textField.becomeFirstResponder()
            
            // TODO: Implement this when iOS 14 passwords bug is fix
//            if let delegate = delegate {
//                delegate.showChangePassView()
//            } else {
//
//            }
        }
    }
    
    // MARK: - ChangePassView
    
    class ChangePassView: UIView {
        
        lazy var stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [
                oldPassField,
                newPassField,
                repeatPassField
            ])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 10
            
            return stack
        }()
        
        lazy var whiteBox: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            
            return view
        }()
        
        let oldPassField: ChangePassTexField = ChangePassTexField(text: "user_change_pass_old".localized)
        let newPassField: ChangePassTexField = ChangePassTexField(text: "user_change_pass_new".localized)
        let repeatPassField: ChangePassTexField = ChangePassTexField(text: "user_change_pass_new".localized)
        
        private var delegate: ChangePassViewProtocol
        
        init(delegate: ChangePassViewProtocol) {
            self.delegate = delegate
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
            oldPassField.textContentType = .password
            newPassField.textContentType = .newPassword
            repeatPassField.textContentType = .newPassword
            
            addSubview(whiteBox)
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                whiteBox.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
                whiteBox.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 90),
                whiteBox.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
                whiteBox.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
            ])
        }
    }
    
    // MARK: - ChangePassTexField
    
    class ChangePassTexField: UITextField {
        
        lazy var rightImage: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
            imageView.contentMode = .scaleAspectFit
            imageView.image = .ic_eye
            imageView.setImage(color: .purple)
            
            return imageView
        }()
                
        init(text: String) {
            super.init(frame: .zero)
            self.placeholder = text
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            borderStyle = .roundedRect
            isSecureTextEntry = true
            layer.cornerRadius = 10
            
            setPlaceholderStyle()
            
            font = .bandar(style: .regular, size: 20)
            textColor = .black
            tintColor = .purple
            
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
            iconContainerView.addSubview(rightImage)
            rightView = iconContainerView
            rightViewMode = .always
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(eyeTapAction(_:)))
            iconContainerView.addGestureRecognizer(tap)
        }
        
        @objc private func eyeTapAction(_ sender: UITapGestureRecognizer) {
            isSecureTextEntry.toggle()
        }
        
        private func setPlaceholderStyle() {
            let attributtes = [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.font: UIFont.bandar(style: .italic, size: 20)
            ]
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributtes)
        }
    }
}

protocol ChangePassViewProtocol {
    func showChangePassView()
    func change(old pass: String, newPass: String)
}
