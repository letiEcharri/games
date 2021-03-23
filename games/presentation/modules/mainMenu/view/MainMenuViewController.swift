//
//  MainMenuViewController.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class MainMenuViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = (UIScreen.main.bounds.width / 2) - 50
        layout.itemSize = CGSize(width: size, height: size)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        
        cv.register(MainMenuCell.self, forCellWithReuseIdentifier: MainMenuCell.identifier)
        
        return cv
    }()
    
    // MARK: - Properties
    
    let presenter: MainMenuPresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: MainMenuPresenterProtocol) {
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
        
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
    }
}

// MARK: - MainMenuPresenterDelegate

extension MainMenuViewController: MainMenuPresenterDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate & DataSource

extension MainMenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuCell.identifier, for: indexPath) as? MainMenuCell else {
            return UICollectionViewCell()
        }
        
        let item = presenter.sections[indexPath.row]
        cell.set(title: item.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSection(with: indexPath.row)
    }
}

// MARK: - NavToolbarProtocol

extension MainMenuViewController: NavToolbarProtocol {
    func toolbarPlayAction() {}
    
    func toolbarHomeAction() {
        presenter.goToHome()
    }
    
    func toolbarProfileAction() {
        presenter.goToProfile()
    }
}
