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
        label.numberOfLines = 0
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

    func setupViews() {
        foodImageView.heightAnchor.constraint(equalTo: foodImageView.widthAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [
            foodImageView,
            nameLabel,
            priceLabel
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var food: CategoryFoodModel? {
        didSet {
            guard let food = food else { return }
            nameLabel.text = food.strMeal
            priceLabel.text = "$\(food.doublePrice)"
        }
    }
}
