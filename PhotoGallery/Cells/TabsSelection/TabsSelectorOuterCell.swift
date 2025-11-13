//
//  TabsSelectorOuterCell.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit
protocol TabsSelectorOuterCellDelegate: AnyObject {
    func didSelectTab(at index: Int)
}
class TabsSelectorOuterCell: UICollectionViewCell {
    //MARK: - Properties & Variables
    @IBOutlet weak var collectionView: UICollectionView!
    var tabItems: [TabItem] = []
    weak var delegate: TabsSelectorOuterCellDelegate?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK: - ConfigureUI
    private func setupViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNibs([TabsSelectorInnerCell.cellIdentifier])
        collectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.collectionViewLayout = layout
    }
    //MARK: - Methods
    func configure(with items: [TabItem], delegate: TabsSelectorOuterCellDelegate?) {
        self.delegate = delegate
        self.tabItems = items
        collectionView.reloadData()
    }
}
