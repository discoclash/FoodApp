//
//  MenuInteractor.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import Foundation

protocol MenuBusinessLogic: AnyObject {
    func fetchMenu()
}

final class MenuInteractor: MenuBusinessLogic {
    private let presenter: MenuPresentationLogic
    private let provider: ProvidesMenu
    
    init(presenter: MenuPresentationLogic, provider: ProvidesMenu) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func fetchMenu() {
        provider.fetchMenu{ [weak presenter] response in
            switch response {
            case let .success(response):
                presenter?.presentMenuList(response)
            case let .failure(error):
                presenter?.presentError(error.localizedDescription)
            }
        }
    }
}
