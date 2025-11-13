
//  PhotoGalleryMainVC+Delegates.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 13/11/2025.
//

import UIKit

// MARK: - UITextFieldDelegate (for search functionality)
extension PhotoGalleryMainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let searchText = textField.text, !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            viewModel.clearSearch()
            loadPhotos() // Load default photos
            return true
        }
        performSearch(query: searchText)
        return true
    }
}


extension PhotoGalleryMainVC: TabsSelectorOuterCellDelegate {
    func didSelectTab(at index: Int) {
        viewModel.selectTab(at: index)
        collectionView.reloadSections(IndexSet(integer: GallerySectionType.tabs.rawValue))
        if index == 0 {
            //show default images
            viewModel.showImages()//no api calling just show the cached items
            collectionView.reloadSections(IndexSet(integer: GallerySectionType.photos.rawValue))
        } else {
            // Show favorites
            viewModel.showFavorites()
            collectionView.reloadSections(IndexSet(integer: GallerySectionType.photos.rawValue))
        }
    }
}

// MARK: - ResultPhotosOuterCellDelegate

extension PhotoGalleryMainVC: ResultPhotosOuterCellDelegate {
    func didToggleFavorite(photoId: String, at index: Int) {
        viewModel.toggleFavorite(photoId: photoId)
        
        if let photosCell = collectionView.cellForItem(
            at: IndexPath(item: 0, section: GallerySectionType.photos.rawValue)
        ) as? ResultPhotosOuterCell {
            photosCell.reloadItem(at: index)
        }
    }
}
