//
//  PhotoGalleryHeaderView.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit

class PhotoGalleryHeaderView: UIView {
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        headerLbl.text = "Search"
        headerLbl.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        headerLbl.textColor = .white
        
        searchField.textColor = .semiLightGray
        searchField.font = UIFont.systemFont(ofSize: 16)
        
        let placeholderText = "Search your Image ..."
        searchField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.semiLightGray]
        )
        searchBgView.backgroundColor = .viewsBgView
        searchBgView.addRoundedCorners(cornerRadius: 10)
    }
}
