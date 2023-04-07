//
//  TopMenuTableViewCell.swift
//  FoodApp
//
//  Created by G on 05.04.2023.
//

import UIKit

// ячейка для оформления верхней части таблицы с меню
class TopMenuTableViewCell: UITableViewCell {
 
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners(cornerRadius: 16)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 16),
            topView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
