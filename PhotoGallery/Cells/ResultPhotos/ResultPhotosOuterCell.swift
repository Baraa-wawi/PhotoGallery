//
//  ResultPhotosOuterCell.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit

protocol ResultPhotosOuterCellDelegate: AnyObject {
    func didToggleFavorite(photoId: String, at index: Int)
}

class ResultPhotosOuterCell: UICollectionViewCell {
    //MARK: - Properties & Variables
    @IBOutlet weak var collectionView: UICollectionView!
    private var photos: [UnsplashPhoto] = []
    weak var delegate: ResultPhotosOuterCellDelegate?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK: - ConfigureUI
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNibs([ResultPhotosCell.cellIdentifier])
        collectionView.backgroundColor = .clear
        
        collectionView.isScrollEnabled = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.collectionViewLayout = layout
    }
    
    //MARK: - Methods
    func configure(with photos: [UnsplashPhoto],delegate: ResultPhotosOuterCellDelegate? = nil) {
        self.photos = photos
        self.delegate = delegate
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func reloadItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
}

//MARK: - ResultPhotosOuterCell + UICollectionViewDelegate+DataSource
extension ResultPhotosOuterCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultPhotosCell.cellIdentifier, for: indexPath) as! ResultPhotosCell
        let photo = photos[indexPath.item]
        cell.configure(with: photo,delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // Side padding
        let itemSpacing: CGFloat = 12 // Space between items
        let totalPadding = (padding * 2) + itemSpacing
        let availableWidth = collectionView.bounds.width - totalPadding
        let itemWidth = availableWidth / 2 // in two columns
        let itemHeight = itemWidth + 100
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ResultPhotosOuterCell: ResultPhotosCellDelegate {
    func didTapFavorite(photoId: String) {
        guard let index = photos.firstIndex(where: { $0.id == photoId }) else { return }
        delegate?.didToggleFavorite(photoId: photoId, at: index)
    }
}
