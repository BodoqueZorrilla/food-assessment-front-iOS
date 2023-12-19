//
//  ShoppingCartViewController.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import UIKit
import StripePaymentSheet

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
    private var paymentIntentClientSecret: String?
    private static let backendURL = URL(string: "http://localhost:6060")!

    private var viewModel = ShoppingCartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setTotalCart()
        setupUI()
        cartTableView.dataSource = self
        cartTableView.delegate = self
        viewModel.fetchShoppongCart()
        cartTableView.reloadData()
        fetchPaymentIntent()
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
        orderButton.setTitle("Order now $\(viewModel.totalCart ?? 0.0)", for: .normal)
    }

    private func fetchPaymentIntent() {
        let url = Self.backendURL.appendingPathComponent("/create-payment-intent")
        
        let shoppingCartContent: [String: Any] = [
            "items": [
                "totalAmount": viewModel.totalCart ?? 0.0
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: shoppingCartContent)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let clientSecret = json["clientSecret"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server."
                self?.displayAlert(title: "Error loading page", message: message)
                return
            }
            
            print("Created PaymentIntent")
            self?.paymentIntentClientSecret = clientSecret
            
            DispatchQueue.main.async {
                self?.orderButton.isEnabled = true
            }
        })
        
        task.resume()
    }

    private func displayAlert(title: String, message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }

    @objc
    private func goToPay() {
        guard let paymentIntentClientSecret = self.paymentIntentClientSecret else {
            return
        }
        
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Assessment Food, Inc."
        
        
        let paymentSheet = PaymentSheet(
            paymentIntentClientSecret: paymentIntentClientSecret,
            configuration: configuration)
        
        paymentSheet.present(from: self) { [weak self] (paymentResult) in
            switch paymentResult {
            case .completed:
                self?.displayAlert(title: "Payment complete!")
            case .canceled:
                print("Payment canceled!")
            case .failed(let error):
                self?.displayAlert(title: "Payment failed", message: error.localizedDescription)
            }
        }
    }
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealsOfCart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: cartIdCell,
                                                   for: indexPath) as? CartTableViewCell
        myCell?.viewModel = viewModel
        myCell?.meal = viewModel.mealsOfCart?[indexPath.row]
        myCell?.selectionStyle = .none
        return myCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
