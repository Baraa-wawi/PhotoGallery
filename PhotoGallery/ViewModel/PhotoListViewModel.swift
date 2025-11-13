//
//  PhotoListViewModel.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import Foundation

class PhotoListViewModel {
    
    // MARK: - Properties
    var photos: [UnsplashPhoto] = [] // for the UI
    private var allPhotos: [UnsplashPhoto] = [] // for Cache
    private var searchResults: [UnsplashPhoto] = [] // Cache for search results
    private var isLoading = false
    private var currentSearchText: String?
    private var currentDisplayMode: DisplayMode = .allPhotos
    
    // Tab items for the selector
    var tabItems: [TabItem] = [
        TabItem(title: "Images", isSelected: true),
        TabItem(title: "My Favourite", isSelected: false)
    ]
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    // MARK: - Fetch Photos
    
    func fetchPhotos(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard !isLoading  else { return }
        clearSearch()
        isLoading = true
        UnsplashService.shared.fetchPhotos(perPage: 30) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let fetchedPhotos):
                self.allPhotos = fetchedPhotos // Store in cache
                self.photos = fetchedPhotos // Update UI list
                completion(.success(()))
                
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Search For Photos
    
    func searchPhotos(query: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        guard !isLoading, !query.isEmpty else { return }
        currentSearchText = query
        currentDisplayMode = .searchResults(query: query)
        isLoading = true
        
        UnsplashService.shared.searchPhotos(query: query) { [weak self] result in
            guard let self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let searchResult):
                self.searchResults = searchResult.results // Store in search cache
                self.photos = searchResult.results // Update UI list
                self.selectTab(at: 0)// when searching go back to the images tab
                completion(.success(()))
                
            case .failure(let error):
                print("Error searching photos: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func showImages() {
        if let query = currentSearchText, !query.isEmpty {
            // There is an active search, restore search results
            currentDisplayMode = .searchResults(query: query)
            photos = searchResults
        } else {
            // No active search, restore general photos
            currentDisplayMode = .allPhotos
            photos = allPhotos
        }
    }
    
    func showFavorites() {
        let sourceSet = Set(allPhotos).union(Set(searchResults))// search result to not be seperated from all photos
        currentDisplayMode = .favorites
        let favoriteIds = FavoritesManager.shared.getFavorites()
        // Filter the combined set of all loaded photos
        photos = sourceSet.filter { favoriteIds.contains($0.id) }
    }
    
    func toggleFavorite(photoId: String) {
        let isFavorited = FavoritesManager.shared.toggleFavorite(photoId: photoId)
        if case .favorites = currentDisplayMode, !isFavorited {
            photos.removeAll { $0.id == photoId }
        }
    }
    
    
    // MARK: - Tab Selection
    // Update selected tab and return the updated tab items
    func selectTab(at index: Int) {
        tabItems = tabItems.enumerated().map { idx, item in
            TabItem(title: item.title, isSelected: idx == index)
        }
    }
    
    func clearSearch() {
        currentSearchText = nil
        searchResults = []
        currentDisplayMode = .allPhotos // Reset display mode
    }
}


