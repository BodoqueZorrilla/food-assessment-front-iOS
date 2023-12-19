//
//  HomeViewModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import Foundation
import CoreData

protocol HomeViewModelProtocol: AnyObject {
    var mainCategories: Categories? { get set }
    var quantityCart: Int? { get set }
    func fetchCategories() async
}

final class HomeViewModel: HomeViewModelProtocol {
    var mainCategories: Categories?
    var quantityCart: Int?
    private let moc = AppDelegate.appDelegate.managedObjectContext

    func fetchCategories() async {
        mainCategories = await ApiCaller.shared.fetch(type: Categories.self,
                                                      from: PathsUrl.categories.pathId)
    }

    func setQuantityCart() {
        guard let moc = moc else { return }
        do {
            let fetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
            let fetchedMeals = try moc.fetch(fetchRequest)
            let mCart = fetchedMeals
            quantityCart = mCart.count
        } catch {
            quantityCart = 0
        }
    }
}
