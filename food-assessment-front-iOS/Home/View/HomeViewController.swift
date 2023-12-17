//
//  HomeViewController.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

class HomeViewController: UIViewController {

    lazy private var categoriesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()

    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await viewModel.fetchCategories()
            self.categoriesTableView.reloadData()
        }
        setupUI()
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
    }

    private func setupUI() {
        categoriesTableView.backgroundColor = .white
        categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesTableView)
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            categoriesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            categoriesTableView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mainCategories?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",
                                                   for: indexPath) as? CategoryTableViewCell
        myCell?.category = viewModel.mainCategories?.categories[indexPath.row]
        return myCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.mainCategories?.categories[indexPath.row])
    }
}
