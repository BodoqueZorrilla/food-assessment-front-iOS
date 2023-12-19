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
    private var notificationButton = SSBadgeButton()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setQuantityCart()
        notificationButton.badge = "\(viewModel.quantityCart ?? 0)"
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(systemName: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        notificationButton.addTarget(self, action: #selector(barButtonAction), for: .touchUpInside)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        navigationController?.navigationBar.tintColor = .black
    }

    @objc
    private func barButtonAction() {
        let viewController = ShoppingCartViewController()
        self.show(viewController, sender: nil)
    }

    private func setupTableView() {
        categoriesTableView = UITableView(frame: view.bounds, style: .plain)
        categoriesTableView.backgroundColor = .white
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        categoriesTableView.showsVerticalScrollIndicator = false
        categoriesTableView.separatorStyle = .none
        view.addSubview(categoriesTableView)
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoriesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        categoriesTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: categoryIdCell)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mainCategories?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: categoryIdCell,
                                                   for: indexPath) as? CategoryTableViewCell
        myCell?.contentView.layer.masksToBounds = true
        myCell?.selectionStyle = .none
        myCell?.category = viewModel.mainCategories?.categories[indexPath.row]
        return myCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categorFoodsViewModel = CategoryFoodViewModel(categoryName: viewModel.mainCategories?.categories[indexPath.row].strCategory ?? "")
        let sectionDetailVC = CategoryFoodsViewController(viewModel: categorFoodsViewModel)
        self.show(sectionDetailVC, sender: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
