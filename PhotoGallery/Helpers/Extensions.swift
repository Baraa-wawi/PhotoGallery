//
//  Extensions.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import UIKit
extension UICollectionView {
    func registerNibs(_ nibs: [String]) {
        for nib in nibs {
            register(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
        }
    }
}

extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIView {
    func addRoundedCorners(cornerRadius: CGFloat = 8.0, corners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = cornerRadius
    }
    
    func makeBorderCircular() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
