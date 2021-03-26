//  
//  LoginViewController.swift
//  games
//
//  Created by Leticia Personal on 21/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .outline, size: 80)
        label.textColor = .white
        
        return label
    }()
    
    lazy var userTextField: LoginTextField = {
        let field = LoginTextField()
        field.isSecureTextEntry = false
        field.tag = 1
        
        return field
    }()
    
    lazy var passTextField: LoginTextField = {
        let field = LoginTextField()
        field.isSecureTextEntry = true
        field.tag = 2
        
        return field
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .bandar(style: .bold, size: 30)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30

        stack.addArrangedSubview(userTextField)
        stack.addArrangedSubview(passTextField)
        stack.addArrangedSubview(loginButton)
        
        return stack
    }()

    // MARK: - Properties
    
    private var presenter: LoginPresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
        fatalError("This init has not been implemented. Use init(:Presenter) instead.")
	}

    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.viewDidLoad()
	}
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        view.backgroundColor = .white
        
        // Gardient
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        view.layer.insertSublayer(gradient, at: 0)
        
        // Views
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    override func setTexts() {
        titleLabel.text = "QUIZ"
        loginButton.setTitle("LOGIN", for: .normal)
        userTextField.placeholder = "user".localized
        passTextField.placeholder = "password".localized
    }
    
    // MARK: - Functions
    
    @objc private func loginAction(_ sender: UIButton) {
        checkTextFields()
    }
    
    private func checkTextFields() {
        if let user = userTextField.text, let pass = passTextField.text,
           user != "" && pass != "" {
            presenter.login(user: user, pass: pass)
        }
    }

}

// MARK: - Presenter Delegate

extension LoginViewController: LoginPresenterDelegate {
    func reloadData() {}
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 1 {
            passTextField.becomeFirstResponder()
        } else if textField.tag == 2 {
            checkTextFields()
        }
        return true
    }
}

// MARK: - Custom Calsses

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
