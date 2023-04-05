//
//  MenuCategoryHeader.swift
//  FoodApp
//
//  Created by G on 04.04.2023.
//

import UIKit

protocol SelectedCategoryDelegate: AnyObject {
    func categoryDidSelected(category: Category)
}

class MenuCategoryHeader: UITableViewHeaderFooterView {
    
    weak var delegate: SelectedCategoryDelegate?
    
    var selectedCategory: Category = .pizza
    
    private var categories: [Category] = [.pizza, .combo, .deserts, .drinks]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        return collection
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

extension MenuCategoryHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            let isSelected = selectedCategory == categories[indexPath.item]
            cell.setupCell(categoryName: categories[indexPath.item].rawValue, isSelected: isSelected)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MenuCategoryHeader: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedCategory = categories[indexPath.item]
//        collectionView.reloadData()
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.categoryDidSelected(category: categories[indexPath.item])
    }
}

extension MenuCategoryHeader: SelectCategoryDelegate {
    func selectCategory(category: Category) {
        selectedCategory = category
        collectionView.reloadData()
        guard let index = categories.firstIndex(where: { $0 == category} ) else { return }
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}