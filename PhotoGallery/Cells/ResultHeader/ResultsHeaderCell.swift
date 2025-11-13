//
//  ResultsHeaderCell.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit

class ResultsHeaderCell: UICollectionViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        headerLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        headerLabel.textColor = .white
        backgroundColor = .clear
    }
    
    func configure(with text: String) {
        headerLabel.text = text
    }
}
