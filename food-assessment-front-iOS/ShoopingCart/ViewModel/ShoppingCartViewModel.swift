//
//  ShoppingCartViewModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import Foundation
import CoreData

protocol ShoppingCartViewModelProtocol: AnyObject {
    var mealsOfCart: [CategoryFoodModel]? { get set }
    func fetchShoppongCart()
}

final class ShoppingCartViewModel: ShoppingCartViewModelProtocol {
    var mealsOfCart: [CategoryFoodModel]?
    private let moc = AppDelegate.appDelegate.managedObjectContext

    func fetchShoppongCart() {
        guard let moc = moc else { return }
        do {
            var mealsOfCart: [CategoryFoodModel] = []
            let fetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
            let fetchedMeals = try moc.fetch(fetchRequest)
            let mCart = fetchedMeals
            if mCart.count != 0 {
                mCart.forEach { meal in
                    let voMeal = CategoryFoodModel(idMeal: String(meal.id),
                                                   strMeal: String(meal.name ?? ""),
                                                   strMealThumb: meal.image ?? "",
                                                   strCategory: "",
                                                   doublePrice: meal.price,
                                                   quantity: Int(meal.quantity))
                    mealsOfCart.append(voMeal)
                }
                self.mealsOfCart = mealsOfCart
            }
        } catch {
            fatalError("Failed to fetch user: \(error)")
        }
    }
}
