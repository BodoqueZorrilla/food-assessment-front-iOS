//
//  HomeViewController.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

final class HomeViewController: UIViewController {

    lazy private var categoriesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private let categoryIdCell = "categoryIdCell"

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
        categoriesTableView = UITableView(frame: view.bounds, style: .plain)
        categoriesTableView.backgroundColor = .white
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesTableView)
        categoriesTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: categoryIdCell)
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mainCategories?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: categoryIdCell,
                                                   for: indexPath) as? CategoryTableViewCell
        myCell?.category = viewModel.mainCategories?.categories[indexPath.row]
        return myCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categorFoodsViewModel = CategoryFoodViewModel(categoryName: viewModel.mainCategories?.categories[indexPath.row].strCategory ?? "")
        let sectionDetailVC = CategoryFoodsViewController(viewModel: categorFoodsViewModel)
        self.show(sectionDetailVC, sender: nil)
    }
}
