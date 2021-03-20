//
//  ProgressStepBar.swift
//  games
//
//  Created by Leticia Personal on 20/03/2021.
//

import UIKit

protocol ProgressStepBarProtocol {
    var viewModel: ProgressStepBar.Model { get }
}

class ProgressStepBar: UIView {
    
    struct Model {
        let steps: Int
        var currentStep: Int
        let rightSteps: [Int]
    }
    
    // MARK: Views
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
                
        for item in 1...viewModel.steps {
            if item >= viewModel.currentStep {
                let circle = Circle(number: item)
                stack.addArrangedSubview(circle)
            } else {
                let rights = viewModel.rightSteps.filter({ $0 == item })
                let circle = Circle(status: rights.count == 0 ? .wrong : .correct)
                stack.addArrangedSubview(circle)
            }
            if item < viewModel.steps {
                stack.addArrangedSubview(getLineView())
            }
        }
        
        return stack
    }()
    
    // MARK: Properties
    
    private var line = UIView()
    
    private var viewModel: Model
    
    // MARK: Initialization
    
    init(viewModel: Model) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
                
        addSubview(stackView)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for (index, item) in stackView.arrangedSubviews.enumerated() {
            if !(item is Circle) {
                if index == 1 {
                    line = item
                } else {
                    item.widthAnchor.constraint(equalTo: line.widthAnchor).isActive = true
                }
            }
        }
    }
    
    private func getLineView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        
        view.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        return view
    }
}

extension ProgressStepBar {
    class Circle: UIView {
        
        enum Status {
            case correct
            case wrong
        }
        
        // MARK: Views
        
        lazy var numberLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .bandar(style: .bold, size: 10)
            label.textColor = .purple
            if let number = number {
                label.text = String(number)
            }
            
            return label
        }()
        
        lazy var image: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            
            switch status {
            case .correct:
                imageView.image = .ic_tick
                imageView.setImage(color: .playGreen)
            case .wrong:
                imageView.image = .ic_cross
            case .none:
                break
            }
            
            return imageView
        }()
        
        // MARK: Properties
        
        private let number: Int?
        private let status: Status?
        private let size: CGFloat = 20
        
        // MARK: Initialization
        
        init(number: Int? = nil, status: Status? = nil) {
            self.number = number
            self.status = status
            super.init(frame: .zero)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            backgroundColor = .white
            layer.cornerRadius = size/2
            clipsToBounds = true
            
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: size),
                widthAnchor.constraint(equalToConstant: size)
            ])
            
            if number != nil {
                layer.borderWidth = 2
                layer.borderColor = UIColor.purple.cgColor
                addSubview(numberLabel)
                NSLayoutConstraint.activate([
                    numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                    numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
                ])
            } else if status != nil {
                addSubview(image)
                NSLayoutConstraint.activate([
                    image.topAnchor.constraint(equalTo: topAnchor),
                    image.bottomAnchor.constraint(equalTo: bottomAnchor),
                    image.leadingAnchor.constraint(equalTo: leadingAnchor),
                    image.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
            }
        }
    }
}
