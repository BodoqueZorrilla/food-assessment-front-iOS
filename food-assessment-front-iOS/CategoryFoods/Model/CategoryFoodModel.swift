//
//  CategoryFoodModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 17/12/23.
//

import Foundation

struct CategoryFoodModel: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strCategory: String
    let doublePrice: Double
    var quantity: Int?
}
