//
//  MenuTableViewCell.swift
//  FoodApp
//
//  Created by G on 05.04.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var category: Category?
    
    lazy var foodImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        return image
    }()
    
    private lazy var foodName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var foodDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var foodPrice: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 1
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImage.image = nil
    }
    
    func setupCell (name: String, description: String, price: Int, category: Category) {
        foodName.text = name
        foodDescription.text = description
        foodPrice.text = "от \(price) руб"
        self.category = category
    }
    
    private func setupView() {
        [foodImage, foodName, foodDescription, foodPrice, separator].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            foodImage.widthAnchor.constraint(equalToConstant: 132),
            foodImage.heightAnchor.constraint(equalToConstant: 132),
            foodImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            foodName.topAnchor.constraint(equalTo: foodImage.topAnchor),
            foodName.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 32),
            foodName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            foodDescription.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 16),
            foodDescription.leadingAnchor.constraint(equalTo: foodName.leadingAnchor),
            foodDescription.trailingAnchor.constraint(equalTo: foodName.trailingAnchor),
            
            foodPrice.topAnchor.constraint(equalTo: foodDescription.bottomAnchor, constant: 16),
            foodPrice.trailingAnchor.constraint(equalTo: foodName.trailingAnchor),
            foodPrice.widthAnchor.constraint(equalToConstant: 87),
            foodPrice.heightAnchor.constraint(equalToConstant: 32),
            foodPrice.bottomAnchor.constraint(lessThanOrEqualTo: separator.topAnchor, constant: -16),
            
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
