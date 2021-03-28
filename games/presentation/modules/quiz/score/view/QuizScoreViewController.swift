//  
//  QuizScoreViewController.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class QuizScoreViewController: BaseViewController, BackgroundImageProtocol {
    
    // MARK: - Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 30)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 70)
        label.textColor = .black
        label.textAlignment = .center
        label.text = String(presenter.score)
        
        return label
    }()
    
    lazy var circleScore: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 75
        circle.layer.borderWidth = 10
        circle.layer.borderColor = UIColor.purple.cgColor
        circle.addShadow()
        
        circle.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            circle.heightAnchor.constraint(equalToConstant: 150),
            circle.widthAnchor.constraint(equalToConstant: 150),
            scoreLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor)
        ])
        
        return circle
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(exitButtonAction(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return button
    }()
    
    lazy var stackView: UIStackView =  {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 40
        stack.alignment = .center
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(circleScore)
        stack.addArrangedSubview(exitButton)
        
        return stack
    }()

    // MARK: - Properties
    
    private var presenter: QuizScorePresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: QuizScorePresenterProtocol) {
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
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.viewDidLoad()
	}
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    override func setTexts() {
        super.setTexts()
        titleLabel.text = "PUNTUACIÓN"
        exitButton.setTitle("¡VALE!", for: .normal)
    }
    
    // MARK: - Functions
    
    @objc private func exitButtonAction(_ sender: UIButton) {
        presenter.exit()
    }
    
}

// MARK: - Presenter Delegate

extension QuizScoreViewController: QuizScorePresenterDelegate {
    func reloadData() {}
}
