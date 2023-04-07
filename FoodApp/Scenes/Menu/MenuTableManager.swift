//
//  MenuTableManager.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit
// протокол делегата для скрола выбранной категории
protocol ScrollToCategoryDelegate: AnyObject {
    func scrollToCategory(index: Int)
}

// протокол делегата для смены выбранной категории в хэдере во время скрола
protocol SelectCategoryDelegate: AnyObject {
    func selectCategory(category: Category)
}

// протокол TableManager'a для внешнего взамодействия
protocol MenuTableManagerProtocol: UITableViewDataSource, UITableViewDelegate {
    var menuModels: [FoodModel] {get set}
    var scrollToCategoryDelegate: ScrollToCategoryDelegate? {get set}
    var selectCategoryDelegate: SelectCategoryDelegate? {get set}
}

// TableManager для заполнения таблицы основной MenuView
final class MenuTableManager: NSObject, MenuTableManagerProtocol {
    var menuModels: [FoodModel] = []
    weak var scrollToCategoryDelegate: ScrollToCategoryDelegate?
    weak var selectCategoryDelegate: SelectCategoryDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return 1}
        if section == 1 {return menuModels.count + 1}
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannersTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopMenuTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let foodModel = menuModels[indexPath.row - 1]
        if let url = URL(string: "http://localhost:5050/" + foodModel.imageUrl) {
            let task = URLSession.shared.dataTask(with: url) { [weak cell] data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    cell?.setupImage(image: UIImage(data: data))
                }
            }
            task.resume()
        }
        cell.setupCell(name: foodModel.name, description: foodModel.description, price: foodModel.price, category: foodModel.category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return nil}
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuCategoryHeader") as! MenuCategoryHeader
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0}
        return 80
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else { return }
        let cells = tableView.visibleCells
        guard cells.count != 0 else { return }
        let cell = cells[(cells.count / 2)]
        guard let menuCell = cell as? MenuTableViewCell else { return }
        guard let header = tableView.headerView(forSection: 1) as? SelectCategoryDelegate else { return }
        selectCategoryDelegate = header
        guard let category = menuCell.category else { return }
        selectCategoryDelegate?.selectCategory(category: category)
    }
}

extension MenuTableManager: SelectedCategoryDelegate {
    func categoryDidSelected(category: Category) {
        if let index = menuModels.firstIndex(where: { $0.category == category}) {
            scrollToCategoryDelegate?.scrollToCategory(index: index + 1)
        }
    }
}
