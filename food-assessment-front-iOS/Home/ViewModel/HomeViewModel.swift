//
//  HomeViewModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var mainCategories: Categories? { get set }
    func fetchCategories() async
}

class HomeViewModel: HomeViewModelProtocol {
    var mainCategories: Categories?
    private var apiCaller = ApiCaller()

    func fetchCategories() async {
        mainCategories = await apiCaller.fetch(type: Categories.self, from: PathsUrl.categories.pathId)
    }
}
