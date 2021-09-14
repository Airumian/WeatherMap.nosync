//
//  CitiesViewController.swift
//  WeatherMap
//
//  Created by Alexander Airumyan on 11.09.2021.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: - Internal Properties
    
    var presenter: CitiesPresenter?
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    private var cities: [City] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Города"
        
        setupConstraints()
        setupTableView()
        presenter?.didTriggerViewReadyEvent()
    }
}

// MARK: - Private Methods

private extension CitiesViewController {
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = self
        registerCells()
        tableView.tableFooterView = UIView()
    }
    
    func registerCells() {
        tableView.register(CityTableViewCell.self,
                           forCellReuseIdentifier: "CityTableViewCell")
    }
    
    func getCityCell(indexPath: IndexPath) -> CityTableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CityTableViewCell",
                for: indexPath) as? CityTableViewCell
        else { return CityTableViewCell() }
        
        let city = cities[indexPath.row]
        cell.configure(title: city.city, temperature: city.temp)
        
        return cell
    }
}

// MARK: - MainView

extension CitiesViewController: CitiesView {
    func updateCities(_ citiesArray: [City]) {
        cities = citiesArray
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCityCell(indexPath: indexPath)
    }
}
