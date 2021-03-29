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
    
    enum TypeView {
        case login
        case singUp
    }
    
    // MARK: - Views
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.purple.withAlphaComponent(0.1)
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .outline, size: 80)
        label.textColor = .purple
        label.text = "QUIZ"
        
        return label
    }()
    
    lazy var leftView: SideView = {
        let view = SideView(title: "login", side: .left)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sideViewTapAction(_:)))
        view.addGestureRecognizer(tap)
        
        view.heightAnchor.constraint(equalToConstant: 380).isActive = true
        
        return view
    }()
    
    lazy var rightView: SideView = {
        let view = SideView(title: "Sign up", side: .right)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sideViewTapAction(_:)))
        view.addGestureRecognizer(tap)
        
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        return view
    }()
    
    lazy var sideStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            leftView,
            rightView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        return stack
    }()
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 153/255, alpha: 1)
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()
    
    lazy var forgotButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .bandar(style: .regular, size: 15)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.setTitle("login_forgot_pass".localized, for: .normal)
        
        return button
    }()
    
    lazy var fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var whiteBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.addShadow()
        
        return view
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .bandar(style: .regular, size: 15)
        label.textColor = .purple
        label.text = "login_account_question".localized
        
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .bandar(style: .bold, size: 15)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.setTitle("login_signup".localized.uppercased(), for: .normal)
        
        return button
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            bottomLabel,
            signUpButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        
        return stack
    }()
    
    var userTextField = TextField(text: "user".localized, image: .ic_user)
    var emailTextField = TextField(text: "email".localized, image: .ic_email)
    var passTextField = TextField(text: "password".localized, image: .ic_lock)
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        view.backgroundColor = .white
        
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(sideStackView)
        NSLayoutConstraint.activate([
            sideStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            sideStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30),
            sideStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30)
        ])

        leftView.selected = true
        passTextField.isSecureTextEntry = true
        
        view.addSubview(whiteBox)
        
        setViewFields()
        
        view.addSubview(fieldsStackView)
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: sideStackView.topAnchor, constant: 80),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            whiteBox.topAnchor.constraint(equalTo: fieldsStackView.topAnchor, constant: -30),
            whiteBox.bottomAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 60),
            whiteBox.leadingAnchor.constraint(equalTo: fieldsStackView.leadingAnchor, constant: -40),
            whiteBox.trailingAnchor.constraint(equalTo: fieldsStackView.trailingAnchor, constant: 40)
        ])
        
        view.addSubview(acceptButton)
        NSLayoutConstraint.activate([
            acceptButton.bottomAnchor.constraint(equalTo: whiteBox.bottomAnchor, constant: 25),
            acceptButton.centerXAnchor.constraint(equalTo: whiteBox.centerXAnchor)
        ])
        
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Functions
    
    @objc private func sideViewTapAction(_ sender: UIGestureRecognizer) {
        if let sideView = sender.view as? SideView {
            sideView.selected = true
            switch sideView.side {
            case .left:
                rightView.selected = false
                presenter.typeView = .login
                
            case .right:
                leftView.selected = false
                presenter.typeView = .singUp
            }
        }
        setViewFields()
    }
    
    private func setViewFields() {
        for item in fieldsStackView.arrangedSubviews {
            item.removeFromSuperview()
        }
        
        switch presenter.typeView {
        case .login:
            fieldsStackView.addArrangedSubview(userTextField)
            fieldsStackView.addArrangedSubview(passTextField)
            fieldsStackView.addArrangedSubview(forgotButton)
            acceptButton.setTitle("LOGIN", for: .normal)
            
        case .singUp:
            fieldsStackView.addArrangedSubview(emailTextField)
            fieldsStackView.addArrangedSubview(userTextField)
            fieldsStackView.addArrangedSubview(passTextField)
            acceptButton.setTitle("SIGN UP", for: .normal)
        }
    }
}

// MARK: - Presenter Delegate

extension LoginViewController: LoginPresenterDelegate {
    func reloadData() {}
}
