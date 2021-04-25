//
//  QuizCategoriesViewController.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCategoriesViewController: BaseViewController, BackgroundImageProtocol {
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.rowHeight = 80
        table.separatorStyle = .none
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        
        table.register(QuizCategoriesCell.self, forCellReuseIdentifier: QuizCategoriesCell.identifier)
        table.register(QuizCategoriesHeaderCell.self, forCellReuseIdentifier: QuizCategoriesHeaderCell.identifier)
        
        return table
    }()
    
    // MARK: - Properties
    
    private let presenter: QuizCategoriesPresenterProtocol
    
    // MARK: - Initialization
    
    init(_ presenter: QuizCategoriesPresenterProtocol) {
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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup UI
    
    override func loadStyle() {
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

}

// MARK: - QuizCategoriesPresenterDelegate

extension QuizCategoriesViewController: QuizCategoriesPresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate & Datasource

extension QuizCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.categories.count > 0 {
            return presenter.categories.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesHeaderCell.identifier, for: indexPath) as? QuizCategoriesHeaderCell else {
                return UITableViewCell()
            }
            
            cell.set(title: "MIX")
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCategoriesCell.identifier, for: indexPath) as? QuizCategoriesCell else {
                return UITableViewCell()
            }
            
            let item = presenter.categories[indexPath.row - 1]
            cell.set(title: item.getName().uppercased())
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(with: indexPath.row)
    }
}

// MARK: - NavToolbarProtocol

extension QuizCategoriesViewController: NavToolbarProtocol {
    func toolbarPlayAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func toolbarHomeAction() {
        presenter.goToHome()
    }
    
    func toolbarProfileAction() {
        presenter.goToProfile()
    }
}
