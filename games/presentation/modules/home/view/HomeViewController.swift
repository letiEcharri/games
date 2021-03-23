//
//  HomeViewController.swift
//  games
//
//  Created by Leticia Personal on 21/02/2021.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 40)
        label.textColor = .black
        label.textAlignment = .center
        
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return label
    }()
    
    lazy var cupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = .ic_cup
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return imageView
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 30)
        label.textColor = .black
        label.textAlignment = .center
        
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(cupImageView)
        stack.addArrangedSubview(scoreLabel)
        
        stack.isHidden  = true
        
        return stack
    }()
    
    lazy var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bandar(style: .bold, size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden  = true
        
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setImage(.ic_toolbar_play, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .playGreen
        button.addTarget(self, action: #selector(playButtonAction(_:)), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return button
    }()
    
    // MARK: - Properties
    
    var loadingImageView: UIImageView?
    
    let presenter: HomePresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: HomePresenterProtocol) {
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
    
    override func loadStyle() {
        addBackgroundImage()
        
        loadingImageView = UIImageView.fromGif(frame: CGRect(x: 0, y: (view.frame.height/2) - 175, width: view.frame.width, height: 350),
                                               resourceName: "loading")
        view.addSubview(loadingImageView ?? UIImageView())
        loadingImageView?.startAnimating()

        
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15)
        ])
        
        self.view.addSubview(totalScoreLabel)
        NSLayoutConstraint.activate([
            totalScoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            totalScoreLabel.topAnchor.constraint(equalTo: cupImageView.bottomAnchor, constant: -42.5)
        ])
        
        self.view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func setTexts() {
        super.setTexts()
//        playButton.setTitle("PLAY", for: .normal)
        scoreLabel.text = "Puntuación: 0"
    }
    
    // MARK: - Functions

    @objc private func playButtonAction(_ sender: UIButton) {
        presenter.play()
    }
}

// MARK: Presenter Delegate

extension HomeViewController: HomePresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            if let user = self.presenter.user {
                self.titleLabel.text = user.nick
                self.scoreLabel.text = "Puntuación: \(user.score)"
                self.totalScoreLabel.text = String(user.score)
                self.cupImageView.setImage(color: user.getColor())
                self.loadingImageView?.stopAnimating()
                self.stackView.isHidden  = false
                self.totalScoreLabel.isHidden  = false
                self.playButton.isEnabled = true
                self.playButton.alpha = 1
            }
            self.hideLoading()
        }
    }
}

// MARK: - NavToolbarProtocol

extension HomeViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        presenter.play()
    }
    
    func toolbarHomeAction() {}
    
    func toolbarProfileAction() {
        presenter.goToProfile()
    }
}
