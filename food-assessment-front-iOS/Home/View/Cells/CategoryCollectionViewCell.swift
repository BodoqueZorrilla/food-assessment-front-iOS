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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black.withAlphaComponent(0.5)
        return label
    }()

    lazy private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = .vertical
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.layer.cornerRadius = 5
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews(){
        addSubview(stackView)
        categoryImageView.heightAnchor.constraint(equalTo: categoryImageView.widthAnchor).isActive = true
        stackView.addArrangedSubview(categoryImageView)
        stackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        

    }

    var category: Category? {
        didSet {
            guard let category = category else { return }
            nameLabel.text = category.strCategory
            DispatchQueue.main.async {
                self.categoryImageView.loadImageUsingCache(withUrl: category.strCategoryThumb)
            }
        }
    }
}
