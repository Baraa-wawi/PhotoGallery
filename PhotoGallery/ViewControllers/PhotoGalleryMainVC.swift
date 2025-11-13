//
//  PhotoGalleryMainVC.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 13/11/2025.
//

import UIKit

class PhotoGalleryMainVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var photoGalleryHeaderView: PhotoGalleryHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let viewModel = PhotoListViewModel()
    private let horizontalPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 12
    private let sectionSpacing: CGFloat = 12
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionViewLayout()
        loadPhotos()
    }
    
    // MARK: - ConfigureUI
    fileprivate func setupViews() {
        setupCollectionView()
        view.backgroundColor = .appBackground
        photoGalleryHeaderView.searchField.delegate = self
    }
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.registerNibs([
            TabsSelectorOuterCell.cellIdentifier,
            ResultsHeaderCell.cellIdentifier,
            ResultPhotosOuterCell.cellIdentifier
        ])
        collectionView.backgroundColor = .clear

    }
    
    fileprivate func setupCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self else { return nil }
            
            guard let sectionType = GallerySectionType(rawValue: sectionIndex) else {
                return nil
            }
            switch sectionType {
            case .tabs:
                return self.createTabsSection()
            case .resultsHeader:
                return self.createResultsHeaderSection()
            case .photos:
                return self.createPhotosSection()
            }
        }
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Layout Sections
    fileprivate func createTabsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: sectionSpacing,
            leading: 0,
            bottom: sectionSpacing,
            trailing: 0
        )
        return section
    }
    
    fileprivate func createResultsHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: horizontalPadding,
            bottom: 16,
            trailing: horizontalPadding
        )
        return section
    }
    
    fileprivate func createPhotosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 44) / 2  // 16 padding left + 16 right + 12 center spacing
        let itemHeight = itemWidth + 100
        let numberOfRows = ceil(Double(viewModel.numberOfPhotos) / 2.0)
        let totalHeight = CGFloat(numberOfRows) * (itemHeight + 12) // 12 spacing between rows
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(totalHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 20,
            trailing: 0
        )
        
        return section
    }
    
    // MARK: - API Calling
    func loadPhotos() {
        viewModel.fetchPhotos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                let sectionsToReload = IndexSet([
                    GallerySectionType.tabs.rawValue,
                    GallerySectionType.photos.rawValue
                ])
                self.collectionView.reloadSections(sectionsToReload)
            case .failure(let error):
                print("Failed to load photos: \(error.localizedDescription)")
            }
        }
    }
    
    func performSearch(query: String) {
        viewModel.searchPhotos(query: query) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                let sectionsToReload = IndexSet([
                    GallerySectionType.tabs.rawValue,
                    GallerySectionType.photos.rawValue
                ])
                self.collectionView.reloadSections(sectionsToReload)
            case .failure(let error):
                print("Failed to search photos: \(error.localizedDescription)")
            }
        }
    }
    
}


