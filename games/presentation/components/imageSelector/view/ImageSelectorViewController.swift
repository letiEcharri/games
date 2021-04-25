//  
//  ImageSelectorViewController.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

protocol ImageSelectorViewDelegate {
    func retrieve(image: UIImage)
}

class ImageSelectorViewController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        
        view.register(ImageSelectorCell.self, forCellWithReuseIdentifier: ImageSelectorCell.identifier)
        
        return view
    }()
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitle("ok".localized.uppercased(), for: .normal)
        button.titleLabel?.font = .bandar(style: .bold, size: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(acceptAction(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()

    // MARK: - Properties
    
    var delegate: ImageSelectorViewDelegate?
    
    private var presenter: ImageSelectorPresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: ImageSelectorPresenterProtocol, delegate: ImageSelectorViewDelegate?) {
        self.presenter = presenter
        self.delegate = delegate
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
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        view.backgroundColor = .white
        
        view.addSubview(acceptButton)
        NSLayoutConstraint.activate([
            acceptButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            acceptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: acceptButton.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Functions

    @objc private func acceptAction(_ sender: UIButton) {
        dismiss(animated: true)
        delegate?.retrieve(image: presenter.selectedImage)
    }
}

// MARK: - Presenter Delegate

extension ImageSelectorViewController: ImageSelectorPresenterDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - CollectionView Delegate & DataSource

extension ImageSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSelectorCell.identifier, for: indexPath) as? ImageSelectorCell else {
            return UICollectionViewCell()
        }
        
        cell.set(image: presenter.images[indexPath.row])
        if indexPath.row == 0 {
            cell.selected(true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for item in collectionView.visibleCells {
            if let cell = item as? ImageSelectorCell {
                cell.selected(false)
            }
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSelectorCell else {
            return
        }
        
        cell.selected(true)
        
        presenter.selectImage(at: indexPath.row)
    }
}
