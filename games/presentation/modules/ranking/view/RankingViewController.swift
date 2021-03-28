//  
//  RankingViewController.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class RankingViewController: BaseViewController, BackgroundImageProtocol {
    
    // MARK: Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .bandar(style: .bold, size: 30)
        label.textColor = .purple
        label.text = "TOP 10"
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.white.cgColor
        table.layer.cornerRadius = 10
        table.separatorStyle = .none
        table.contentInset.top = 20
        table.delegate = self
        table.dataSource = self
        
        table.register(RankingCell.self, forCellReuseIdentifier: RankingCell.identifier)
        
        table.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        return table
    }()

    // MARK: - Properties
    
    private var presenter: RankingPresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: RankingPresenterProtocol) {
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
        
//        view.addSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    // MARK: - Functions

}

// MARK: - Presenter Delegate

extension RankingViewController: RankingPresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingCell.identifier, for: indexPath) as? RankingCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let model = RankingCell.Model(left: "ranking_position".localized,
                                      center: "user".localized,
                                      right: "score".localized,
                                      header: true)
            cell.set(with: model)
        } else {
            if let users = presenter.users {
                let item = users[indexPath.row - 1]
                let model = RankingCell.Model(left: String(indexPath.row),
                                          center: item.nick,
                                          right: String(item.score),
                                          header: false)
                cell.set(with: model)
            }
        }
        
        return cell
    }
}

// MARK: - NavToolbarProtocol

extension RankingViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        
    }
    
    func toolbarHomeAction() {}
    
    func toolbarProfileAction() {
        
    }
}
