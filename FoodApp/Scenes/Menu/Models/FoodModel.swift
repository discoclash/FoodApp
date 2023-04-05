//
//  FoodModel.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import UIKit

struct FoodModel: Decodable {
    let category: Category
    let name: String
    let description: String
    let price: Int
    let imageUrl: String
}

enum Category: String, Decodable {
    case pizza = "Пицца"
    case combo = "Комбо"
    case deserts = "Десерты"
    case drinks = "Напитки"
}
