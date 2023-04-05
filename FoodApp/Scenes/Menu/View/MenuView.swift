//
//  MenuView.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit

protocol DisplayMenuView: UIView {
    func configure(withViewModel: MenuDataFlow.DisplayMenu.ViewModel)
}

final class MenuView: UIView {
    
    private let tableManager: MenuTableManagerProtocol
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва  "
        label.addTrailing(image: UIImage(named: "CitySelector"))
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.register(BannersTableViewCell.self, forCellReuseIdentifier: "BannersTableViewCell")
        tableView.register(MenuCategoryHeader.self, forHeaderFooterViewReuseIdentifier: "MenuCategoryHeader")
        tableView.register(TopMenuTableViewCell.self, forCellReuseIdentifier: "TopMenuTableViewCell")
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        return tableView
    }()
    
    required init(tableManager: MenuTableManagerProtocol) {
        self.tableManager = tableManager
        super.init(frame: .zero)
        configure()
        makeConstraints()
        tableView.dataSource = tableManager
        tableView.delegate = tableManager
        tableManager.scrollToCategoryDelegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MenuView {
    func configure() {
        addSubview(cityLabel)
        addSubview(tableView)
        backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
    }
    
    func makeConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

extension MenuView: DisplayMenuView {
    func configure(withViewModel model: MenuDataFlow.DisplayMenu.ViewModel) {
        tableManager.menuModels = model
        tableView.reloadData()
    }
}

extension MenuView: ScrollToCategoryDelegate {
    func scrollToCategory(index: Int) {
        tableView.scrollToRow(at: IndexPath(row: index, section: 1), at: .top, animated: true)
    }
}
