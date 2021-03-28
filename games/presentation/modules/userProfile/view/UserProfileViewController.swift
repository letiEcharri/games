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
        imageV.isUserInteractionEnabled = true
        imageV.clipsToBounds = true
        
        imageV.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage(_:)))
        imageV.addGestureRecognizer(tap)
        
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
    var changePassView: ChangePassView?

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
    
    @objc private func didTapImage(_ sender: UIGestureRecognizer) {
        let viewController = AppDependencies().makeImageSelector(delegate: self)
        present(viewController, animated: true)
    }

}

// MARK: - Presenter Delegate

extension UserProfileViewController: UserProfilePresenterDelegate {
    func reloadData() {
        
        titleLabel.text = presenter.user?.nick
        if let userImage = presenter.user?.image {
            imageView.image = userImage
        }
        
        emailTexfField = TexFieldView(text: presenter.user?.email ?? "", isSecureTextEntry: false)
        emailTexfField?.textField.delegate = self
        passTexfField = TexFieldView(text: "*********", isSecureTextEntry: true)
        passTexfField?.textField.delegate = self
        passTexfField?.delegate = self
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

// MARK: - ChangePassViewProtocol

extension UserProfileViewController: ChangePassViewProtocol {
    func showChangePassView() {
        changePassView = ChangePassView(delegate: self)
        if let changePassView = changePassView {
            view.addSubview(changePassView)
            NSLayoutConstraint.activate([
                changePassView.topAnchor.constraint(equalTo: view.topAnchor),
                changePassView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                changePassView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                changePassView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
    
    func change(old pass: String, newPass: String) {
        changePassView?.removeFromSuperview()
    }
}

// MARK: - NavToolbarProtocol

extension UserProfileViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        presenter.goToMainMenu()
    }
    
    func toolbarHomeAction() {
        presenter.goToHome()
    }
    
    func toolbarProfileAction() {}
}

// MARK: - ImageSelectorViewDelegate

extension UserProfileViewController: ImageSelectorViewDelegate {
    func retrieve(image: UIImage) {
        imageView.image = image
        UserDefaults.standard.set(image.pngData(), forKey: UserDefaultsKeys.image.rawValue)
    }
}
