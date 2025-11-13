//
//  PhotoGalleryMainVC+UICollectionView.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 15/11/2025.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension PhotoGalleryMainVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GallerySectionType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // sections has outer cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = GallerySectionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        switch sectionType {
        case .tabs:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabsSelectorOuterCell.cellIdentifier,for: indexPath) as! TabsSelectorOuterCell
            cell.configure(with: viewModel.tabItems, delegate: self)
            return cell
            
        case .resultsHeader:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsHeaderCell.cellIdentifier, for: indexPath ) as! ResultsHeaderCell
            cell.configure(with: "Results")
            return cell
            
        case .photos:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultPhotosOuterCell.cellIdentifier,for: indexPath) as! ResultPhotosOuterCell
            cell.configure(with: viewModel.photos, delegate: self)
            return cell
        }
    }
}
