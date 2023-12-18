//
//  CategoryFoodViewModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 17/12/23.
//

import Foundation

protocol CategoryFoodViewModelProtocol: AnyObject {
    var categoryFoods: [CategoryFoodModel]? { get set }
    func fetchCategoryFoods() async
}

class CategoryFoodViewModel: CategoryFoodViewModelProtocol {
    var categoryFoods: [CategoryFoodModel]?
    var categoryName: String?
    init(categoryName: String) {
        self.categoryName = categoryName
    }

    func fetchCategoryFoods() async {
        guard let categoryName = categoryName else { return }
        categoryFoods = await ApiCaller.shared.fetch(type: [CategoryFoodModel].self,
                                                     from: PathsUrl.categoryFoods(category: categoryName).pathId)
    }
}

