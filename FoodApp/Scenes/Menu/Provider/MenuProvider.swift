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
            completion(result)
        }
    }
}
