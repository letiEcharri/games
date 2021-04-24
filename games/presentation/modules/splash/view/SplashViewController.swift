//  
//  SplashViewController.swift
//  games
//
//  Created by Leticia Personal on 23/04/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class SplashViewController: BaseViewController {

    // MARK: - Properties
    
    private var presenter: SplashPresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
        fatalError("This init has not been implemented. Use init(:Presenter) instead.")
	}

    // MARK: - Life cycle
    
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.viewDidLoad()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        view.backgroundColor = .white
        
        let width = view.frame.width - 40
        let gifView = UIView(frame: CGRect(x: 20, y: view.center.y - (width/2), width: width, height: width))
        gifView.clipsToBounds = true
        gifView.layer.cornerRadius = gifView.frame.width / 2
        view.addSubview(gifView)
        
        if let gifImageView = UIImageView.fromGif(frame: .zero, resourceName: "questionGif") {
            gifImageView.translatesAutoresizingMaskIntoConstraints = false
            
            gifView.addSubview(gifImageView)
            NSLayoutConstraint.activate([
                gifImageView.leadingAnchor.constraint(equalTo: gifView.leadingAnchor),
                gifImageView.trailingAnchor.constraint(equalTo: gifView.trailingAnchor),
                gifImageView.topAnchor.constraint(equalTo: gifView.topAnchor),
                gifImageView.bottomAnchor.constraint(equalTo: gifView.bottomAnchor)
            ])
            
            gifImageView.startAnimating()
        }
    }
    
    // MARK: - Functions

}

// MARK: - Presenter Delegate

extension SplashViewController: SplashPresenterDelegate {
    func reloadData() {}
}
