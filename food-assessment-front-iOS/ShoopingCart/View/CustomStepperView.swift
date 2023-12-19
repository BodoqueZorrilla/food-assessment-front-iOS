//
//  CustomStepperView.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import UIKit

protocol StepperDelegate {
    func updateQuantity(isMore: Bool, meal: CategoryFoodModel) -> Int
    func getMealQuantity(mealId: String) -> Int
}

final class CustomStepperView: UIView {
    var countMealItem: Int?
    var meal: CategoryFoodModel?
    var delegate: StepperDelegate?
    lazy private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle",
                                 withConfiguration: UIImage.SymbolConfiguration(scale: .medium)),
                        for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()

    lazy private var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle",
                                 withConfiguration: UIImage.SymbolConfiguration(scale: .medium)),
                        for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            minusButton,
            quantityLabel,
            plusButton
        ])
        stackView.axis  = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layer.cornerRadius = 5
        stackView.backgroundColor = .gray
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        quantityLabel.text = "\(countMealItem ?? 0)"
        minusButton.addTarget(self, action:#selector(decrisElement), for: .touchUpInside)
        plusButton.addTarget(self, action:#selector(incristElement), for: .touchUpInside)
    }

    @objc
    private func incristElement() {
        if let meal = meal {
            quantityLabel.text = "\(delegate?.updateQuantity(isMore: true, meal: meal) ?? 0)"
        }
    }

    @objc
    private func decrisElement() {
        if let meal = meal {
            quantityLabel.text = "\(delegate?.updateQuantity(isMore: false, meal: meal) ?? 0)"
        }
    }
}
