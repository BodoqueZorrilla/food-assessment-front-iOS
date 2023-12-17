//
//  CategoryCollectionViewCell.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black.withAlphaComponent(0.5)
        return label
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
        stackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    var category: Category? {
        didSet {
            guard let category = category else { return }
            nameLabel.text = category.strCategory
        }
    }
    
}
