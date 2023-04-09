//
//  MenuProvider.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import Foundation

protocol ProvidesMenu: AnyObject {
    func fetchMenu(completion: @escaping (Result<[FoodModel], Error>) -> Void)
}

final class MenuProvider: ProvidesMenu {
    private let service: NetworkServicing
    
    init(service: NetworkServicing) {
        self.service = service
    }
    
    func fetchMenu(completion: @escaping (Result<[FoodModel], Error>) -> Void) {
        service.fetchMenu { result in
            switch result {
            case let .success(response):
                CoreDataManager.shared.deleteAllCells()
                for (index, foodModel) in response.enumerated() {
                    CoreDataManager.shared.createCell(index: Int16(index),
                                                      category: foodModel.category.rawValue,
                                                      name: foodModel.name,
                                                      description: foodModel.description,
                                                      price: Int16(foodModel.price),
                                                      image: nil)
                }
                completion(.success(response))
            case let .failure(error):
                let cells = CoreDataManager.shared.fetchCells()
                if cells.count > 0 {
                    var menuModel: [FoodModel] = []
                    for cell in cells {
                        menuModel.append(FoodModel(category: (Category(rawValue: cell.foodCategory) ?? .unknown),
                                                   name: cell.foodName,
                                                   description: cell.foodDetailes,
                                                   price: Int(cell.foodPrice),
                                                   imageUrl: "Unknown",
                                                   imageData: cell.foodImage))
                    }
                    completion(.success(menuModel))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
