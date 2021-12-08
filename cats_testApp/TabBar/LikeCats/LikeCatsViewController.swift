//
//  LikeCatsViewController.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit

final class LikeCatsViewController: UIViewController {
    
    private var viewModel: LikeCatsViewModelProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func loadView() {
        super.loadView()
        viewModel = LikeCatsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .systemGray5
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupTableViewAutoLayout()
    }
    
    private func setupTableViewAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension LikeCatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .systemPurple
        cell.textLabel?.font = UIFont(name: "Futura Bold", size: 20)
        cell.textLabel?.text = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LikeCatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metrics.heightCell
    }
}

