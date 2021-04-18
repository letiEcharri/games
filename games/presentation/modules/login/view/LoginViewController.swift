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
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = .bandar(style: .regular, size: 18)
        label.textColor = .white
        
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .bandar(style: .bold, size: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showSignUpView(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signUpStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            signUpLabel,
            signUpButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    var signUpView: SignUpView?

    // MARK: - Properties
    
    private var signUpViewYConstraint: NSLayoutConstraint?
    
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
        hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
	}
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
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
        
        view.addSubview(signUpStackView)
        NSLayoutConstraint.activate([
            signUpStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func setTexts() {
        titleLabel.text = "QUIZ"
        loginButton.setTitle("LOGIN", for: .normal)
        userTextField.placeholder = "user".localized
        passTextField.placeholder = "password".localized
        signUpLabel.text = "login_singUp_question".localized
        signUpButton.setTitle("login_singUp_button".localized.uppercased(), for: .normal)
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
    
    @objc private func showSignUpView(_ sender: UIButton) {
        signUpView = SignUpView(presenter: presenter)
        if let signUpView = signUpView {
            view.addSubview(signUpView)
            signUpViewYConstraint = signUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            if let signUpViewYConstraint = signUpViewYConstraint {
                NSLayoutConstraint.activate([
                    signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                    signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                    signUpViewYConstraint
                ])
            }
        }
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if signUpView != nil {
            signUpViewYConstraint?.constant = -80
        }
    }

    override func keyboardWillHide(notification: NSNotification) {
        if signUpView != nil {
            signUpViewYConstraint?.constant = 0
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
