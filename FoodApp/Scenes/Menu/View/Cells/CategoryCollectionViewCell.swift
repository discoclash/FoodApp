//
//  CategoryCollectionViewCell.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit

// ячейка коллекции с категорией меню
class CategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 16
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(categoryName: String, isSelected: Bool) {
        categoryLabel.text = categoryName
        categoryLabel.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        if isSelected {
            categoryLabel.layer.borderWidth = 0
            categoryLabel.layer.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2).cgColor
            categoryLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        } else {
            categoryLabel.layer.borderWidth = 1
            categoryLabel.layer.backgroundColor = UIColor.clear.cgColor
            categoryLabel.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        }
    }
    
    private func setup() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
}
