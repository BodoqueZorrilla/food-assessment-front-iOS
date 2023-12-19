//
//  CartCoreData.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 18/12/23.
//

import Foundation
import CoreData

public class MCartObject: NSManagedObject {

}

extension MCartObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MCart> {
        return NSFetchRequest<MCart>(entityName: "MCart")
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var strId: String?
    @NSManaged public var name: String?
    @NSManaged public var price: NSNumber?
    @NSManaged public var image: String?
    @NSManaged public var quantity: NSNumber?
}

class VOCart: NSObject {
    var id: Int64 = 0
    var strId: String = ""
    var name: String = ""
    var price: Double = 0.0
    var image: String = ""
    var quantity: Int64 = 0

    init(id: Int64,
         strId: String,
         name: String,
         price: Double,
         image: String,
         quantity: Int64) {
        self.id = id
        self.strId = strId
        self.name = name
        self.price = price
        self.image = image
        self.quantity = quantity
    }
}
