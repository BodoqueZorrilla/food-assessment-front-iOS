//
//  ShoppingCartViewController.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    lazy private var cartTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy private var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Order now", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private let cartIdCell = "cartIdCell"

    private var viewModel = ShoppingCartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        cartTableView.dataSource = self
        cartTableView.delegate = self
        viewModel.fetchShoppongCart()
        cartTableView.reloadData()
    }

    private func setupUI() {
        self.title = "My Shopping Cart"
        self.view.backgroundColor = .white
        cartTableView = UITableView(frame: view.bounds, style: .plain)
        cartTableView.backgroundColor = .white
        cartTableView.translatesAutoresizingMaskIntoConstraints = false
        cartTableView.showsVerticalScrollIndicator = false
        view.addSubview(cartTableView)
        view.addSubview(orderButton)
        orderButton.addTarget(self, action: #selector(goToPay), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cartTableView.topAnchor.constraint(equalTo: view.topAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -16),
            cartTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cartTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            orderButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            orderButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            orderButton.heightAnchor.constraint(equalToConstant: 50),
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        cartTableView.register(CartTableViewCell.self, forCellReuseIdentifier: cartIdCell)
    }

    @objc
    private func goToPay() {
        
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsOfCart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cartIdCell,
                                                   for: indexPath) as? CartTableViewCell
        myCell?.meal = viewModel.mealsOfCart?[indexPath.row]
        myCell?.selectionStyle = .none
        return myCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
