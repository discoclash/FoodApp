//
//  MenuFactory.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit
// фабрика для создания ViewController'a
struct MenuFactory {
    func build() -> UIViewController {
        let service = MenuService(uri: "http://localhost:5050/menu.json")
        let provider = MenuProvider(service: service)
        let presenter = MenuPresenter()
        let interactor = MenuInteractor(presenter: presenter, provider: provider)
        let viewController = MenuViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
