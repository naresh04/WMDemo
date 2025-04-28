//
//  CountryViewController.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import UIKit

class CountryViewController: UIViewController {
    private let tableView = UITableView()
    private var searchController: UISearchController!
    private let viewModel: CountryViewModel
    
    init(viewModel: CountryViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        loadData()
    }

    
    private func setupUI() {
        view.backgroundColor = .systemBackground
                
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
                
        tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
                
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            navigationItem.searchController = searchController
    }
    
    private func bindViewModel(){
        viewModel.onDataUpdate = { [weak self] in
                   Task {  self?.tableView.reloadData() }
               }
               viewModel.onError = { [weak self] error in
                   DispatchQueue.main.async {
                       let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default))
                       self?.present(alert, animated: true)
                   }
               }
    }
    
    private func loadData(){
        Task {
                await viewModel.fetchCountries()
        }
    }

}


extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let country = viewModel.country(at: indexPath.row) {
            cell.configure(with: country)
        }
        
        return cell
    }
}
extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        Task {
            await viewModel.search(with: searchController.searchBar.text ?? "")
        }
    }
}
