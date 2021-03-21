//
//  QuizQuestionViewController.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizQuestionViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .purple
        label.font = .bandar(style: .bold, size: 23)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var boxQuestion: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.purple.cgColor
        
        view.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            questionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    // MARK: - Properties
    
    let presenter: QuizQuestionPresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: QuizQuestionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    
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
        addBackgroundImage()
        
        addData()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Private Functions
    
    @objc private func buttonAction(_ sender: AnswerButton) {
        sender.set(status: presenter.isAnswerRight(with: sender.key))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presenter.next(selected: sender.key)
        }
    }
    
    private func addData() {
        questionLabel.text = presenter.question.question
        stackView.addArrangedSubview(boxQuestion)
        
        let button1 = AnswerButton(title: presenter.question.answers.answer1, key: "answer1")
        button1.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        let button2 = AnswerButton(title: presenter.question.answers.answer2, key: "answer2")
        button2.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        let button3 = AnswerButton(title: presenter.question.answers.answer3, key: "answer3")
        button3.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        let button4 = AnswerButton(title: presenter.question.answers.answer4, key: "answer4")
        button4.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
    }
}

// MARK: - QuizQuestionPresenterDelegate

extension QuizQuestionViewController: QuizQuestionPresenterDelegate {
    func reloadData() {
        for item in stackView.arrangedSubviews {
            item.removeFromSuperview()
        }
        addData()
        updateProgressStepsBar()
    }
}

// MARK: - QuizQuestionPresenterDelegate

extension QuizQuestionViewController: ProgressStepBarProtocol {
    var viewModel: ProgressStepBar.Model {
        presenter.getStepsModel()
    }
}

// MARK: - AnswerButton View

extension QuizQuestionViewController {
    
    class AnswerButton: UIButton {
        
        var title: String
        var key: String
        
        init(title: String, key: String) {
            self.title = title
            self.key = key
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = .white
            titleLabel?.font = .bandar(style: .regular, size: 20)
            titleLabel?.numberOfLines = 0
            titleLabel?.textAlignment = .center
            setTitleColor(.purple, for: .normal)
            layer.cornerRadius = 10
            layer.borderWidth = 1
            layer.borderColor = UIColor.purple.cgColor
            
            setTitle(title, for: .normal)

            heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
        
        func set(status: Bool) {
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 0
            backgroundColor = status ? .playGreen : .red
        }
        
    }
}
