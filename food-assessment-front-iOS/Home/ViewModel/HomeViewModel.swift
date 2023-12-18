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

final class HomeViewModel: HomeViewModelProtocol {
    var mainCategories: Categories?

    func fetchCategories() async {
        mainCategories = await ApiCaller.shared.fetch(type: Categories.self,
                                                      from: PathsUrl.categories.pathId)
    }
}
