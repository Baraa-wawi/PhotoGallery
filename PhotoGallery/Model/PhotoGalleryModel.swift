//
//  PhotoGalleryModel.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

struct UnsplashPhoto: Codable , Hashable {
    let id: String
    let description: String?
    let altDescription: String?
    let urls: PhotoUrls
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
        case user
    }
    
    static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PhotoUrls: Codable {
    let small: String

}

struct User: Codable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

//MARK: - Search
struct SearchResult: Codable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Tab Model
struct TabItem {
    let title: String
    let isSelected: Bool
}

// MARK: - Section Types
enum GallerySectionType: Int, CaseIterable {
    case tabs = 0
    case resultsHeader
    case photos
}

// MARK: - Display Mode
// Track what photos to display (all, search results, or favorites)
enum DisplayMode {
    case allPhotos
    case searchResults(query: String)
    case favorites
}
