//
//  CategoryFoodViewModel.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 17/12/23.
//

import Foundation
import CoreData

protocol CategoryFoodViewModelProtocol: AnyObject {
    var categoryFoods: [CategoryFoodModel]? { get set }
    func fetchCategoryFoods() async
}

class CategoryFoodViewModel: CategoryFoodViewModelProtocol {
    var categoryFoods: [CategoryFoodModel]?
    var categoryName: String?
    private let moc = AppDelegate.appDelegate.managedObjectContext
    init(categoryName: String) {
        self.categoryName = categoryName
    }

    func fetchCategoryFoods() async {
        guard let categoryName = categoryName else { return }
        categoryFoods = await ApiCaller.shared.fetch(type: [CategoryFoodModel].self,
                                                     from: PathsUrl.categoryFoods(category: categoryName).pathId)
    }

    func handlerQuantity(isMore: Bool, meal: CategoryFoodModel) {
        guard let moc = moc else { return }
        let mealFetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
        mealFetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: Int(meal.idMeal) ?? 0))

        do {
            let fetchedMovie = try moc.fetch(mealFetchRequest)
            if fetchedMovie.count > 0 {
                let mealDataStore = fetchedMovie[0]
                if mealDataStore.id >= 0 {
                    self.updateMeal(isMore: isMore, meal: meal)
                } else {
                    self.saveMeal(meal: meal)
                }
            } else {
                self.saveMeal(meal: meal)
            }
        } catch {
            fatalError("Failed to get meal: \(error)")
        }
    }

    private func saveMeal(meal: CategoryFoodModel) {
        guard let moc = moc else { return }
        let coreDataCart = MCart(context: moc)
        coreDataCart.id = Int64(meal.idMeal) ?? 0
        coreDataCart.strId = meal.idMeal
        coreDataCart.name = meal.strMeal
        coreDataCart.image = meal.strMealThumb
        coreDataCart.price = meal.doublePrice
        coreDataCart.quantity = 1
        do {
            try moc.save()
        } catch _ as NSError {
            print("Faile to save meal")
        }
    }

    private func updateMeal(isMore: Bool, meal: CategoryFoodModel) {
        guard let moc = moc else { return }
        let mealFetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
        mealFetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: Int(meal.idMeal) ?? 0))
        
        do {
            let fetchedMeal = try moc.fetch(mealFetchRequest)
            if fetchedMeal.count > 0 {
                let coreDataMeal = fetchedMeal[0]
                coreDataMeal.quantity = isMore ? (coreDataMeal.quantity + 1) :
                                                 (coreDataMeal.quantity - 1)
                do {
                    try moc.save()
                } catch _ as NSError {
                    print("Error updating")
                }
            }
        } catch {
            fatalError("Failed to update Meal: \(error)")
        }
    }

    func singleMeal(meal: String) -> Int {
        guard let moc = moc else { return 0 }
        let mealFetchRequest: NSFetchRequest<MCart> = MCart.fetchRequest()
        mealFetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: Int(meal) ?? 0))
        
        do {
            let fetchedMeal = try moc.fetch(mealFetchRequest)
            if fetchedMeal.count > 0 {
                let coreDataMeal = fetchedMeal[0]
                return Int(coreDataMeal.quantity)
            } else {
                return 0
            }
        } catch {
            print("Failed to update Movie: \(error)")
            return 0
        }
    }
}

extension CategoryFoodViewModel: StepperDelegate {
    func getMealQuantity(mealId: String) -> Int {
        return singleMeal(meal: mealId)
    }
    
    func updateQuantity(isMore: Bool, meal: CategoryFoodModel) -> Int {
        handlerQuantity(isMore: isMore, meal: meal)
        return singleMeal(meal: meal.idMeal)
    }
}
