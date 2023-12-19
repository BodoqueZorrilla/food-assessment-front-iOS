//
//  CategoryFoodsCollectionViewCell.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 17/12/23.
//

import UIKit

class CategoryFoodsCollectionViewCell: UICollectionViewCell {
    lazy private var foodImageView: UIImageView = {
        var img = UIImageView(image: #imageLiteral(resourceName: "OSLogo"))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var stepperView: CustomStepperView = {
        let stepper = CustomStepperView(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    private func setupViews() {
        foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [
            foodImageView,
            nameLabel,
            priceLabel,
            stepperView
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stepperView.heightAnchor.constraint(equalToConstant: 40),
            stepperView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            stepperView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(food: CategoryFoodModel, viewModel: CategoryFoodViewModel){
        nameLabel.text = food.strMeal
        priceLabel.text = "$\(food.doublePrice)"
        stepperView.meal = food
        stepperView.delegate = viewModel
        stepperView.quantityLabel.text =  "\(HandlerFoodInCartManager.shared.singleMeal(meal: food.idMeal))"
        DispatchQueue.main.async {
            self.foodImageView.loadImageUsingCache(withUrl: food.strMealThumb)
        }
    }
}
