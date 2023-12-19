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
    var totalCart: Double? { get set }
}

final class ShoppingCartViewModel: ShoppingCartViewModelProtocol {
    var mealsOfCart: [CategoryFoodModel]?
    var totalCart: Double?
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

    func setTotalCart() {
        guard let moc = moc else { return }
        do {
            let fetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
            let fetchedMeals = try moc.fetch(fetchRequest)
            let mCart = fetchedMeals
            if mCart.count != 0 {
                var totalSum: Double = 0.0
                mCart.forEach { meal in
                    let addCount = meal.price * Double(meal.quantity)
                    totalSum += addCount
                }
                self.totalCart = totalSum
            }
        } catch {
            fatalError("Failed to fetch user: \(error)")
        }
    }

    func eraseCart() {
        guard let moc = moc else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "MCart", in: moc)
        fetchRequest.includesPropertyValues = false
        do {
            if let results = try moc.fetch(fetchRequest) as? [NSManagedObject] {
                moc.performAndWait {
                    do {
                        for result in results {
                            moc.delete(result)
                        }
                        try moc.save()
                    }catch {
                        print("deleteAllData", "Error in deleteAllData Meals")
                    }
                }
            }
        } catch {
            print("deleteAllData", "Error in deleteAllData Meals")
        }
    }
}

extension ShoppingCartViewModel: StepperDelegate {
    func getMealQuantity(mealId: String) -> Int {
        return HandlerFoodInCartManager.shared.singleMeal(meal: mealId)
    }
    
    func updateQuantity(isMore: Bool, meal: CategoryFoodModel) -> Int {
        setTotalCart()
        HandlerFoodInCartManager.shared.handlerQuantity(isMore: isMore, meal: meal)
        return HandlerFoodInCartManager.shared.singleMeal(meal: meal.idMeal)
    }
}
