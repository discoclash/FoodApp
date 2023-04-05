//
//  MainTabBarController.swift
//  FoodApp
//
//  Created by G on 03.04.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTabBar()
    }
    
    private func setupControllers() {
        let menu = MenuFactory().build()
        menu.tabBarItem.title = "Меню"
        menu.tabBarItem.image = UIImage(named: "Menu")
        
        let contacts = UIViewController()
        contacts.tabBarItem.title = "Контакты"
        contacts.tabBarItem.image = UIImage(named: "Contacts")
        
        let profile = UIViewController()
        profile.tabBarItem.title = "Профиль"
        profile.tabBarItem.image = UIImage(named: "Profile")
        
        let cart = UIViewController()
        cart.tabBarItem.title = "Корзина"
        cart.tabBarItem.image = UIImage(named: "Cart")
        
        self.viewControllers = [menu, contacts, profile, cart]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1).cgColor
        tabBar.layer.borderWidth = 0.3
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
    }
}
