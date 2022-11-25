//
//  ViewController.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var charModel: [Character] = []
    private var filteredCharacters: [Character] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
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
        setupLayout()
        fetchData()
        setupSearchBar()
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
            charModel = character
            tableView.reloadData()
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .white
        definesPresentationContext = true
        
    }
}

//MARK: - UiTableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacters.count : charModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return TableViewCell()}
        let character = isFiltering ? filteredCharacters[indexPath.row] : charModel[indexPath.row]
        cell.configure(from: character)
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UiTableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let discrVC = DescriptionViewController()
        let charModel = isFiltering ? filteredCharacters[indexPath.row] : charModel[indexPath.row]
        discrVC.configure(from: charModel)
        navigationController?.pushViewController(discrVC, animated: true)
    }
}

//MARK: - UiNavigationBar

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

//MARK: - UiSearchResultsUptading

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: searchController.searchBar.text ?? "")
    }
    
    func filterContent(searchText: String) {
        filteredCharacters = charModel.filter({ character in
            character.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
