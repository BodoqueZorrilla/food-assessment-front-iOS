//
//  CategoryCollectionViewCell.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    lazy private var categoryImageView: UIImageView = {
        var img = UIImageView(image: #imageLiteral(resourceName: "OSLogo"))
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black.withAlphaComponent(0.5)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews(){
        addSubview(cardView)
        cardView.addSubview(categoryImageView)
        cardView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            categoryImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo:cardView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        

    }

    var category: Category? {
        didSet {
            guard let category = category else { return }
            nameLabel.text = "   \(category.strCategory)"
            DispatchQueue.main.async {
                self.categoryImageView.loadImageUsingCache(withUrl: category.strCategoryThumb)
            }
        }
    }
}
