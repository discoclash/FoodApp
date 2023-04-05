//
//  MenuPresenter.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import Foundation

protocol MenuPresentationLogic: AnyObject {
    func presentMenuList(_ response: MenuDataFlow.DisplayMenu.Response)
    func presentError(_ response: MenuDataFlow.DisplayError.Response)
}

final class MenuPresenter: MenuPresentationLogic {
    
    weak var viewController: MenuDisplayLogic?
    
    func presentMenuList(_ response: MenuDataFlow.DisplayMenu.Response) {
        let viewModel = response
        viewController?.displayMenuList(viewModel)
    }
    
    func presentError(_ response: MenuDataFlow.DisplayError.Response) {
        let viewModel = response
        viewController?.displayError(viewModel)
    }
}
