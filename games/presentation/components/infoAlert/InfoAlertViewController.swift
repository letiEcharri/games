//  
//  InfoAlertViewController.swift
//  games
//
//  Created by Leticia Personal on 27/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

struct InfoAlertModel {
    var type: InfoAlertViewController.AlertType
    var description: String
    var action: (() -> Void)?
}

class InfoAlertViewController: BaseViewController {
    
    enum AlertType {
        case error
        case warning
        case info
    }
    
    // MARK: - Views
    
    lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return icon
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bandar(style: .bold, size: 20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .bandar(style: .regular, size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("ok".localized.uppercased(), for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        
        return button
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.setTitleColor(.purple, for: .normal)
        button.setTitle("cancel".localized.uppercased(), for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var doubleButtonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            leftButton,
            rightButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
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

    // MARK: - Properties
    
    private var buttonsHeight: CGFloat = 50
    
    private var viewModel: InfoAlertModel
    
	// MARK: - Initializers
	
	init(_ viewModel: InfoAlertModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
        fatalError("This init has not been implemented. Use init(:Presenter) instead.")
	}

    // MARK: - Life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        switch viewModel.type {
        case .error:
            iconImageView.image = .ic_cross
            titleLabel.text = "alert_error_title".localized.uppercased()
            descriptionLabel.text = viewModel.description
            rightButton.backgroundColor = .red
            leftButton.setTitleColor(.red, for: .normal)
            leftButton.addBorder(.top, color: .red, thickness: 1)
            stackView.addArrangedSubview(iconImageView)
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(descriptionLabel)
            
        case .warning:
            iconImageView.image = .ic_warning
            descriptionLabel.text = viewModel.description
            rightButton.backgroundColor = .purple
            leftButton.addBorder(.top, color: .purple, thickness: 1)
            stackView.addArrangedSubview(iconImageView)
            stackView.addArrangedSubview(descriptionLabel)
            
        case .info:
            descriptionLabel.text = viewModel.description
            rightButton.backgroundColor = .purple
            leftButton.addBorder(.top, color: .purple, thickness: 1)
            stackView.addArrangedSubview(descriptionLabel)
        }
        
        
        if let action = viewModel.action {
            rightButton.addAction {
                self.dismiss(animated: true)
                action()
            }
            leftButton.addTarget(self, action: #selector(exitAction(_:)), for: .touchUpInside)
            whiteBox.addSubview(doubleButtonStackView)
            NSLayoutConstraint.activate([
                doubleButtonStackView.leadingAnchor.constraint(equalTo: whiteBox.leadingAnchor),
                doubleButtonStackView.trailingAnchor.constraint(equalTo: whiteBox.trailingAnchor),
                doubleButtonStackView.bottomAnchor.constraint(equalTo: whiteBox.bottomAnchor)
            ])
            
        } else {
            rightButton.addTarget(self, action: #selector(exitAction(_:)), for: .touchUpInside)
            whiteBox.addSubview(rightButton)
            NSLayoutConstraint.activate([
                rightButton.leadingAnchor.constraint(equalTo: whiteBox.leadingAnchor),
                rightButton.trailingAnchor.constraint(equalTo: whiteBox.trailingAnchor),
                rightButton.bottomAnchor.constraint(equalTo: whiteBox.bottomAnchor)
            ])
        }
        
        view.addSubview(whiteBox)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            whiteBox.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            whiteBox.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: buttonsHeight + 30),
            whiteBox.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            whiteBox.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
        ])
    }
    
    // MARK: - Functions
    
    @objc private func exitAction(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
