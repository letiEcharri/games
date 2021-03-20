//
//  BaseViewController.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        imageView.image = .ic_background
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadStyle()
        setTexts()
    }
    
    func loadStyle() {}
    
    func setTexts() {}

    func addBackgroundImage() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    private func checkProgressSteps() {
        if let viewController = self as? ProgressStepBarProtocol {
            let progressBar = ProgressStepBar(viewModel: viewController.viewModel)
            view.addSubview(progressBar)
            NSLayoutConstraint.activate([
                progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
                progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            for item in view.subviews where (item is ProgressStepBar) {
                item.removeFromSuperview()
            }
        }
    }
    
    func updateProgressStepsBar() {
        for item in view.subviews where (item is ProgressStepBar) {
            item.removeFromSuperview()
        }
        checkProgressSteps()
        view.setNeedsDisplay()
    }
}
