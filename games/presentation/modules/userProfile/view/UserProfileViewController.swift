//  
//  UserProfileViewController.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class UserProfileViewController: BaseViewController, BackgroundImageProtocol {
    
    // MARK: - Views
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.layer.borderWidth = 5
        imageV.layer.borderColor = UIColor.white.cgColor
        imageV.image = .ic_generic_user
        imageV.layer.cornerRadius = 75
        
        imageV.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return imageV
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bandar(style: .bold, size: 30)
        label.textColor = .black
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        
        return stack
    }()
    
    lazy var closeSessionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("close_session".localized.uppercased(), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeSessionAction(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()
    
    var emailTexfField: TexFieldView?
    var passTexfField: TexFieldView?

    // MARK: - Properties
    
    private var presenter: UserProfilePresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: UserProfilePresenterProtocol) {
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
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(closeSessionButton)
        NSLayoutConstraint.activate([
            closeSessionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            closeSessionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeSessionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
    }
    
    // MARK: - Functions
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
        
        emailTexfField?.textField.disable()
        passTexfField?.textField.disable()
    }
    
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0,
               let passField = passTexfField {
                let keyboardY = view.frame.height - keyboardSize.height
                if (passField.frame.origin.y + 160) > keyboardY {
                    self.view.frame.origin.y -= 100
                }
                
            }
        }
    }
    
    @objc private func closeSessionAction(_ sender: UIButton) {
        let viewModel = InfoAlertModel(type: .info, description: "close_session_message".localized, action: {
            self.presenter.closeSession()
        })
        showAlert(with: viewModel)
    }

}

// MARK: - Presenter Delegate

extension UserProfileViewController: UserProfilePresenterDelegate {
    func reloadData() {
        
        titleLabel.text = presenter.user?.nick
        
        emailTexfField = TexFieldView(text: presenter.user?.email ?? "", isSecureTextEntry: false)
        emailTexfField?.textField.delegate = self
        passTexfField = TexFieldView(text: "*********", isSecureTextEntry: true)
        passTexfField?.textField.delegate = self
        if let emailTexfField = emailTexfField, let passTexfField = passTexfField {
            stackView.addArrangedSubview(emailTexfField)
            stackView.addArrangedSubview(passTexfField)
        }
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension UserProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let field = textField as? TextField, let text = field.text {
            field.disable()
            presenter.textfieldAction(isSecureEntry: textField.isSecureTextEntry, text: text)
        }
        return true
    }
}

extension UserProfileViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        presenter.goToMainMenu()
    }
    
    func toolbarHomeAction() {
        presenter.goToHome()
    }
    
    func toolbarProfileAction() {}
}

// MARK: - Internal classes

extension UserProfileViewController {
    
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
            let stack = UIStackView(arrangedSubviews: [
                titleLabel,
                txtStackView
            ])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            
            return stack
        }()
        
        var isSecureTextEntry: Bool = false
        private var text: String
        var textField = TextField()
        
        init(text: String, isSecureTextEntry: Bool) {
            self.text = text
            self.isSecureTextEntry = isSecureTextEntry
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            backgroundColor = .clear
            
            heightAnchor.constraint(equalToConstant: 70).isActive = true
        
            titleLabel.text = isSecureTextEntry ? "password".localized : "email".localized
            textField.isSecureTextEntry = isSecureTextEntry
            textField.text = text
            
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
            textField.becomeFirstResponder()
        }
    }
}

