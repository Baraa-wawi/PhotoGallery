//
//  File.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit
//MARK: - UICollectionViewDelegate+Datasource
extension TabsSelectorOuterCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabsSelectorInnerCell.cellIdentifier, for: indexPath) as! TabsSelectorInnerCell
        let tabItem = tabItems[indexPath.item]
        cell.configure(with: tabItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectTab(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tabItem = tabItems[indexPath.item]
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let textWidth = (tabItem.title as NSString).size(withAttributes: [.font: font]).width
        let width = textWidth + 32
        return CGSize(width: width, height: 40)
    }
}
