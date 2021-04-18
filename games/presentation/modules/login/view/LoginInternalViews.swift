//
//  LoginInternalViews.swift
//  games
//
//  Created by Leticia Personal on 18/04/2021.
//

import UIKit

extension LoginViewController {
    
    class LoginTextField: UITextField {
        
        // MARK: Views
        
        lazy var leftImage: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
            imageView.contentMode = .scaleAspectFit
            imageView.image = isSecureTextEntry ? .ic_lock : .ic_user
            imageView.setImage(color: .white)
            
            return imageView
        }()
        
        lazy var rightImage: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
            imageView.contentMode = .scaleAspectFit
            imageView.image = .ic_eye
            imageView.setImage(color: .white)
            
            return imageView
        }()
        
        // MARK: Properties
        
        override var isSecureTextEntry: Bool {
            didSet {
                addLeftImage()
                addRightImage()
            }
        }
        
        override var placeholder: String? {
            didSet {
                setPlaceholderStyle()
            }
        }
        
        // MARK: Initialization
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Functions
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
            layer.cornerRadius = 10
            
            font = .bandar(style: .regular, size: 25)
            textColor = .white
            tintColor = .white
            
            heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        private func addLeftImage() {
            let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 50, height: 40))
            iconContainerView.addSubview(leftImage)
            leftView = iconContainerView
            leftViewMode = .always
        }
        
        private func addRightImage() {
            if isSecureTextEntry {
                let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
                iconContainerView.addSubview(rightImage)
                rightView = iconContainerView
                rightViewMode = .always
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(eyeTapAction(_:)))
                iconContainerView.addGestureRecognizer(tap)
            }
        }
        
        @objc private func eyeTapAction(_ sender: UITapGestureRecognizer) {
            isSecureTextEntry.toggle()
        }
        
        private func setPlaceholderStyle() {
            let attributtes = [
                NSAttributedString.Key.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5),
                NSAttributedString.Key.font: UIFont.bandar(style: .italic, size: 20)
            ]
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributtes)
        }
    }
}

extension LoginViewController {
    
    class SignUpTextField: UITextField {
        
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
            font = .bandar(style: .regular, size: 20)
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

extension LoginViewController {
    
    class SignUpView: UIView {
        
        lazy var signUpButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .purple
            button.layer.cornerRadius = 10
            button.titleLabel?.font = .bandar(style: .bold, size: 25)
            button.setTitleColor(.white, for: .normal)
            button.setTitle("SIGN UP", for: .normal)
            button.addTarget(self, action: #selector(signUpAction(_:)), for: .touchUpInside)
            
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            return button
        }()
        
        lazy var errorLabel: UILabel = {
            let label = UILabel()
            label.font = .bandar(style: .regular, size: 15)
            label.textColor = .red
            label.numberOfLines = 0
            
            return label
        }()
        
        var emailTextField = LoginViewController.SignUpTextField(text: "email".localized, image: .ic_email)
        var passTextField = LoginViewController.SignUpTextField(text: "password".localized, image: .ic_lock)
        
        lazy var stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [
                emailTextField,
                passTextField,
                errorLabel,
                signUpButton
            ])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 30
            
            return stack
        }()
        
        private var presenter: LoginPresenterProtocol
        
        init(presenter: LoginPresenterProtocol) {
            self.presenter = presenter
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            clipsToBounds = true
            backgroundColor = .white
            layer.cornerRadius = 20
            
            heightAnchor.constraint(equalToConstant: 300).isActive = true
            
            errorLabel.isHidden = true
            
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
        
        @objc private func signUpAction(_ sender: UIButton) {
            checkFields { (email, pass) in
                self.presenter.signUp(email: email, pass: pass)
            }
        }
        
        private func checkFields(completion: @escaping (String, String) -> Void) {
            if let email = emailTextField.text, let pass = passTextField.text {
                presenter.checkSignUpFields(email: email, pass: pass) { (error) in
                    if let error = error {
                        self.errorLabel.text = error
                        self.errorLabel.isHidden = false
                    } else {
                        completion(email, pass)
                    }
                }
            }
        }
    }
}
