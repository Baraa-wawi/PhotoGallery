//
//  ImageCacheManager.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 15/11/2025.
//

import UIKit

/// singleton to cache images
class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private let imageCache = NSCache<NSString, UIImage>()
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = urlString as NSString
        
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in /// for better results we can use kingfisher or any other library , it is done with data task just for this task
            guard let self = self,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else {
                
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
