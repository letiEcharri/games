//  
//  HomeRankingViewController.swift
//  games
//
//  Created by Leticia Personal on 28/03/2021.
//
//  Clean Templates by Leticia Echarri
//

import UIKit

class HomeRankingViewController: BaseViewController, BackgroundImageProtocol {
    
    // MARK: Views
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.contentInset.top = 20
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        
        table.register(HomeTableCell.self, forCellReuseIdentifier: HomeTableCell.identifier)
        table.register(HomeRankingCell.self, forCellReuseIdentifier: HomeRankingCell.identifier)
        
        table.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        return table
    }()
    
    var loadingImageView: UIImageView?

    // MARK: - Properties
    
    private var presenter: HomeRankingPresenterProtocol
    
	// MARK: - Initializers
	
	init(_ presenter: HomeRankingPresenterProtocol) {
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
        showGifLoading(true)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.viewDidLoad()
	}
	
    // MARK: - Setup UI
    
    override func loadStyle() {
        super.loadStyle()
        
        let tabsView = TabsView()
        tabsView.delegate = self
        view.addSubview(tabsView)
        NSLayoutConstraint.activate([
            tabsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tabsView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Functions
    
    private func showGifLoading(_ value: Bool) {
        if value {
            loadingImageView = UIImageView.fromGif(frame: CGRect(x: (view.frame.width/2) - 100, y: (view.frame.height/2) - 175, width: 200, height: 200),
                                                   resourceName: "loading")
            loadingImageView?.backgroundColor = .clear
            view.addSubview(loadingImageView ?? UIImageView())
            loadingImageView?.startAnimating()
        } else {
            loadingImageView?.removeFromSuperview()
        }
    }

}

// MARK: - Presenter Delegate

extension HomeRankingViewController: HomeRankingPresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.showGifLoading(false)
            switch self.presenter.selectedTAB {
            case .score:
                self.tableView.backgroundColor = .clear
                self.tableView.layer.borderColor = UIColor.clear.cgColor
            case .ranking:
                self.tableView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                self.tableView.layer.borderWidth = 1
                self.tableView.layer.borderColor = UIColor.white.cgColor
                self.tableView.layer.cornerRadius = 10
            }
            self.tableView.reloadData()
        }
    }
}

extension HomeRankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.presenter.selectedTAB {
        case .score:
            return presenter.user != nil ? 1 : 0
        case .ranking:
            if let topUsers = presenter.topUsers {
                return topUsers.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.selectedTAB {
        case .score:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, for: indexPath) as? HomeTableCell,
                  let user = presenter.user else {
                return UITableViewCell()
            }
            
            cell.set(with: user)
            return cell
            
        case .ranking:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRankingCell.identifier, for: indexPath) as? HomeRankingCell else {
                return UITableViewCell()
            }
            
            if indexPath.row == 0 {
                let model = HomeRankingCell.Model(left: "ranking_position".localized,
                                          center: "user".localized,
                                          right: "score".localized,
                                          header: true)
                cell.set(with: model)
            } else {
                if let users = presenter.topUsers {
                    let item = users[indexPath.row - 1]
                    let model = HomeRankingCell.Model(left: String(indexPath.row),
                                              center: item.nick,
                                              right: String(item.score),
                                              header: false)
                    cell.set(with: model)
                }
            }
            
            return cell
        }
        
    }
}

// MARK: - NavToolbarProtocol

extension HomeRankingViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        presenter.goToMainMenu()
    }
    
    func toolbarHomeAction() {}
    
    func toolbarProfileAction() {
        presenter.goToUserProfile()
    }
}

// MARK: - TabsView Delegate

extension HomeRankingViewController: HomeRankingTabsViewDelegate {
    func select(tab: HomeRankingPresenter.Tab) {
        presenter.select(tab: tab)
    }
}

// MARK: - Internal classes

extension HomeRankingViewController {
    
    class TabsView: UIView {
        
        lazy var leftButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.font = .bandar(style: .bold, size: 20)
            button.setTitleColor(.purple, for: .normal)
            button.setTitle("score".localized, for: .normal)
            button.contentVerticalAlignment = .fill
            button.contentMode = .center
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
                        
            return button
        }()
        
        lazy var rightButton: UIButton = {
            let button = UIButton()
            button.titleLabel?.font = .bandar(style: .bold, size: 20)
            button.setTitleColor(.purple, for: .normal)
            button.setTitle("Ranking", for: .normal)
            button.contentVerticalAlignment = .fill
            button.contentMode = .center
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            button.tag = 1
                        
            return button
        }()
        
        lazy var stackView: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [
                leftButton,
                rightButton
            ])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            
            return stack
        }()
        
        lazy var marker: UIView =  {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .purple
            
            view.heightAnchor.constraint(equalToConstant: 2).isActive = true
                        
            return view
        }()
        
        var delegate: HomeRankingTabsViewDelegate?
                
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configureView() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = .clear
            addBorder(.bottom, color: .lightGray, thickness: 1)
            
            heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
            addSubview(marker)
            NSLayoutConstraint.activate([
                marker.bottomAnchor.constraint(equalTo: bottomAnchor),
                marker.leadingAnchor.constraint(equalTo: leadingAnchor),
                marker.widthAnchor.constraint(equalTo: leftButton.widthAnchor)
            ])
        }
        
        @objc private func buttonAction(_ sender: UIButton) {
            marker.removeFromSuperview()
            addSubview(marker)
            marker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            if sender.tag == 0 {
                marker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                marker.widthAnchor.constraint(equalTo: leftButton.widthAnchor).isActive = true
            } else {
                marker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                marker.widthAnchor.constraint(equalTo: rightButton.widthAnchor).isActive = true
            }
            
            if let delegate = delegate {
                delegate.select(tab: sender.tag == 0 ? .score : .ranking)
            }
        }
    }
}

protocol HomeRankingTabsViewDelegate {
    func select(tab: HomeRankingPresenter.Tab)
}
