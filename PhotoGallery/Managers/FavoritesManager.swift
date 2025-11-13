//
//  FavoritesManager.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 15/11/2025.
//

import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    private let favoritesKey = "savedFavoritePhotos"
    
    private init() {}
    
    // Get all favorite photo IDs
    func getFavorites() -> Set<String> {
        if let favoriteArray = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            return Set(favoriteArray)
        }
        return Set<String>()
    }
    
    // Check if a photo is favorited
    func isFavorite(photoId: String) -> Bool {
        return getFavorites().contains(photoId)
    }
    
    // Toggle favorite status (add if not favorited, remove if favorited)
    func toggleFavorite(photoId: String) -> Bool {
        var favorites = getFavorites()
        
        if favorites.contains(photoId) {
            //remove from Favorites
            favorites.remove(photoId)
            saveFavorites(favorites)
            return false
        } else {
            // Add to favorites
            favorites.insert(photoId)
            saveFavorites(favorites)
            return true
        }
    }
    
    // Save favorites to UserDefaults
    private func saveFavorites(_ favorites: Set<String>) {
        let favoriteArray = Array(favorites)
        UserDefaults.standard.set(favoriteArray, forKey: favoritesKey)
        UserDefaults.standard.synchronize()
    }
    
    func clearAllFavorites() { /// i used this for debugging 
        UserDefaults.standard.removeObject(forKey: favoritesKey)
        UserDefaults.standard.synchronize()
    }
}
