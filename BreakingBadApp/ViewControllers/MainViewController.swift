//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
//MARK: - Private properties
    
    private var character: [Character] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()

//MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.rowHeight = 100
        setupLayout()
        fetchData()
    }

//MARK: - Private functions
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func fetchData() {
        NetworkManager.share.fetchData(from: Link.BreakingBadAPI.rawValue) { [unowned self] character in
            self.character = character
            tableView.reloadData()
        }
    }
}

//MARK: - UiTableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return TableViewCell()}
        let character = character[indexPath.row]
        cell.configure(from: character)
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UiTableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController {
    
    private func setupNavigationBar() {
        title = "Breaking Bad"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.tintColor = .black
    }
}
