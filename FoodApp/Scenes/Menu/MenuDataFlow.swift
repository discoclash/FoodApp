//
//  MenuDataFlow.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import Foundation

// потоки в VIP-цикле
enum MenuDataFlow {
    
    // загрузка меню
    enum DisplayMenu {
        typealias Request = Void
        typealias Response = [FoodModel]
        typealias ViewModel = [FoodModel]
    }
    
    //  ошибка при загрузке
    enum DisplayError {
        typealias Response = String
        typealias ViewModel = String
    }
}
