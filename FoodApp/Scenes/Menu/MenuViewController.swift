//
//  MenuViewController.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import UIKit

protocol MenuDisplayLogic: AnyObject {
    func displayMenuList(_ viewModel: MenuDataFlow.DisplayMenu.ViewModel)
    func displayError(_ viewModel: MenuDataFlow.DisplayError.ViewModel)
}

class MenuViewController: UIViewController {
    
    private let tableManager: MenuTableManagerProtocol = MenuTableManager()
    lazy var contantView: DisplayMenuView = MenuView(tableManager: tableManager)
    private let interactor: MenuBusinessLogic
    
    init(interactor: MenuBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contantView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchMenu()
    }
}

extension MenuViewController: MenuDisplayLogic {
    func displayMenuList(_ viewModel: MenuDataFlow.DisplayMenu.ViewModel) {
        contantView.configure(withViewModel: viewModel)
    }
    
    func displayError(_ viewModel: MenuDataFlow.DisplayError.ViewModel) {
    }
}
