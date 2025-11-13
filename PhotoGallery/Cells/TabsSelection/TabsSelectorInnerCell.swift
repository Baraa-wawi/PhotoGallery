//
//  TabsSelectorInnerCell.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit

class TabsSelectorInnerCell: UICollectionViewCell {
    //MARK: - Properties & Variables
    @IBOutlet weak var tabLbl: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    //MARK: - ConfigureUI
    fileprivate func setupViews() {
        contentView.addRoundedCorners(cornerRadius: 10)
        tabLbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        tabLbl.textAlignment = .center
    }
    //MARK: - Methods
    func configure(with tabItem: TabItem) {
        tabLbl.text = tabItem.title
        contentView.backgroundColor = tabItem.isSelected ? .appPrimary : .viewsBgView
        tabLbl.textColor = .white 
    }
}
