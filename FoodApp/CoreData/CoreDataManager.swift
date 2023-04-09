//
//  CoreDataManager.swift
//  FoodApp
//
//  Created by G on 08.04.2023.
//

import UIKit
import CoreData

// MARK: - CRUD

final  class CoreDataManager   {
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createCell (index: Int16, category: String, name: String, description: String, price: Int16, image: Data?) {
        guard let menuCellEntityDescription = NSEntityDescription.entity(forEntityName: "MenuCell", in: context) else { return }
        let cell = MenuCell(entity: menuCellEntityDescription, insertInto: context)
        cell.index = index
        cell.foodCategory = category
        cell.foodName = name
        cell.foodDetailes = description
        cell.foodPrice = price
        cell.foodImage = image
        appDelegate.saveContext()
    }
    
    func fetchCells() -> [MenuCell] {
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuCell")
        let cells = (try? context.fetch(fetchRequest) as? [MenuCell]) ?? []
        return cells
    }
    
    func updateCell (index: Int16, newImage: Data) {
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuCell")
        guard let cells = (try? context.fetch(fetchRequest) as? [MenuCell]),
              let cell = cells.first(where: {$0.index == index}) else { return }
        cell.foodImage = newImage
        appDelegate.saveContext()
    }
    
    func deleteAllCells() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuCell")
        let cells = try? context.fetch(fetchRequest) as? [MenuCell]
        cells?.forEach { context.delete($0) }
        appDelegate.saveContext()
    }
}
