//
//  DateListViewController.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import UIKit

class DateListViewController: UIViewController {
    
    // MARK: Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel: DateListViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: DateListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        navigationItem.title = "Astronomy Picture of the Day"
        
        view = UIView()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: Methods
    
    private func bindViewModel() {        
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        viewModel.fetchDates()
    }

}

// MARK: UITableViewDelegate

extension DateListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let date = viewModel.getDate(at: indexPath)
        let detailViewModel = DetailViewModel(date: date)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: UITableViewDataSource

extension DateListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDates
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let date = viewModel.getDateString(at: indexPath)
        cell.textLabel?.text = date
        return cell
    }
    
}
