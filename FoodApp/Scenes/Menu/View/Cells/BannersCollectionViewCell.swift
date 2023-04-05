//
//  BannersCollectionViewCell.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit

// ячейка коллекции с баннером
class BannersCollectionViewCell: UICollectionViewCell {
    lazy var banner: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(bannerName: String) {
        banner.image = UIImage(named: bannerName)
        banner.contentMode = .center
    }
    
    private func setup() {
        contentView.addSubview(banner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: contentView.topAnchor),
            banner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            banner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            banner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
}
