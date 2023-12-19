//
//  CartTableViewCell.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import UIKit

final class CartTableViewCell: UITableViewCell {

    var viewModel: ShoppingCartViewModel?
    
    lazy private var mealImageView: UIImageView = {
        var img = UIImageView(image: #imageLiteral(resourceName: "OSLogo"))
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var cardView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.23
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy private var stepperView: CustomStepperView = {
        let stepper = CustomStepperView(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        self.addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews(){
        cardView.isUserInteractionEnabled = true
        addSubview(cardView)
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            priceLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackMainView = UIStackView(arrangedSubviews: [
            mealImageView,
            stackView
        ])
        
        stackMainView.axis = .horizontal
        stackMainView.distribution = .fillEqually
        stackMainView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackMainView)
        cardView.addSubview(stepperView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackMainView.topAnchor.constraint(equalTo: cardView.topAnchor),
            stackMainView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackMainView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stackMainView.bottomAnchor.constraint(equalTo: stepperView.topAnchor, constant: -16),
            stepperView.topAnchor.constraint(equalTo: stackMainView.bottomAnchor),
            stepperView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stepperView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            stepperView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5),
            stepperView.heightAnchor.constraint(equalToConstant: 30),
            mealImageView.heightAnchor.constraint(equalToConstant: 60),
            mealImageView.widthAnchor.constraint(equalToConstant: 60),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    var meal: CategoryFoodModel? {
        didSet {
            guard let meal = meal else { return }
            nameLabel.text = meal.strMeal
            priceLabel.text = "$\(meal.doublePrice)"
            stepperView.delegate = viewModel
            stepperView.countMealItem = meal.quantity ?? 2
            stepperView.meal = meal
            stepperView.quantityLabel.text =  "\(meal.quantity ?? 2)"
            DispatchQueue.main.async {
                self.mealImageView.loadImageUsingCache(withUrl: meal.strMealThumb)
            }
        }
    }
}

