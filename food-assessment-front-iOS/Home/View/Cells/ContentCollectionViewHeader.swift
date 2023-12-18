//
//  ContentCollectionViewHeader.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

final class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        sectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sectionNameLabel)
        
        NSLayoutConstraint.activate([
            sectionNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
}
