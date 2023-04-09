//
//  MenuCell+CoreDataProperties.swift
//  FoodApp
//
//  Created by G on 09.04.2023.
//
//

import Foundation
import CoreData

import Foundation
import CoreData

@objc(MenuCell)
public class MenuCell: NSManagedObject {}

extension MenuCell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuCell> {
        return NSFetchRequest<MenuCell>(entityName: "MenuCell")
    }

    @NSManaged public var foodName: String
    @NSManaged public var foodDetailes: String
    @NSManaged public var foodPrice: Int16
    @NSManaged public var foodImage: Data?
    @NSManaged public var index: Int16
    @NSManaged public var foodCategory: String

}

extension MenuCell : Identifiable {}
