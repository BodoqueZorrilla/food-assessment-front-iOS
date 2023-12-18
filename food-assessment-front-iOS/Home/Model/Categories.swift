//
//  Categories.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import Foundation

struct Categories: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
