//
//  ResultPhotosCell.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
///

import UIKit

protocol ResultPhotosCellDelegate: AnyObject {
    func didTapFavorite(photoId: String)
}

class ResultPhotosCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var photoImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var favBgView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    
    // MARK: - Properties
    private var currentImageURL: String?
    private var currentPhotoId: String?
    
    weak var delegate: ResultPhotosCellDelegate?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImgView.image = nil
        currentImageURL = nil
        currentPhotoId = nil
        delegate = nil
    }
    //MARK: - ConfigureUI
    fileprivate func setupViews() {
        setupLabels()
        photoImgView.addRoundedCorners(cornerRadius: 10)
        favBgView.backgroundColor = .white.withAlphaComponent(0.29)
        favBgView.makeBorderCircular()
        favBtn.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func setupLabels() {
        titleLbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLbl.textColor = .white
        titleLbl.numberOfLines = 1
        
        subtitleLbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLbl.textColor = .semiLightGray
        subtitleLbl.numberOfLines = 3
        
    }
    
    //MARK: - Methods
    func configure(with photo: UnsplashPhoto,delegate: ResultPhotosCellDelegate?) {
        self.delegate = delegate
        self.currentPhotoId = photo.id
        titleLbl.text = photo.user.name
        subtitleLbl.text = photo.altDescription ?? photo.description ?? "Untitled"
        updateFavoriteIcon(isFavorited: FavoritesManager.shared.isFavorite(photoId: photo.id))
        
        // Load image if URL changed
        if currentImageURL != photo.urls.small {
            currentImageURL = photo.urls.small
            loadImage(from: photo.urls.small)
        }
    }
    
    // Update favorite icon appearance
    private func updateFavoriteIcon(isFavorited: Bool) {
        favIcon.tintColor = isFavorited ? .systemRed : .white
    }
    
    private func loadImage(from urlString: String) {
        self.photoImgView.image = nil
        
        ImageCacheManager.shared.loadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            if self.currentImageURL == urlString {
                self.photoImgView.image = image
            }
        }
    }
    
    //MARK: - Selectors
    @objc private func favoriteButtonTapped() {
        guard let photoId = currentPhotoId else { return }
        delegate?.didTapFavorite(photoId: photoId)
    }
    
}
