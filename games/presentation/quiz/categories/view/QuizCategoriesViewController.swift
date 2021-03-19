//
//  QuizCategoriesViewController.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import UIKit

class QuizCategoriesViewController: BaseViewController {
    
    // MARK: - Views
    
    lazy var headerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.layer.cornerRadius = 35
        
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        return button
    }()
    
    lazy var tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        
        view.addSubview(headerButton)
        NSLayoutConstraint.activate([
            headerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            headerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.rowHeight = 80
        table.separatorStyle = .none
        
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
        addBackgroundImage()
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40)
        ])
    }
    
    override func setTexts() {
        headerButton.setTitle("MIX", for: .normal)
    }

}

// MARK: - QuizCategoriesPresenterDelegate

extension QuizCategoriesViewController: QuizCategoriesPresenterDelegate {
    func reloadData() {
        
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
            cell.set(title: item.name.uppercased())
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(with: indexPath.row)
    }
}
