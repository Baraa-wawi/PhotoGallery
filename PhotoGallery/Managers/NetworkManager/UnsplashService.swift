//
//  UnsplashService.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import Foundation
class UnsplashService {
    
    static let shared = UnsplashService()
    private init() {}
    
    func fetchPhotos(///Default per page is 20
        page: Int = 1,
        perPage: Int = 20,
        completion: @escaping (Result<[UnsplashPhoto], NetworkError>) -> Void
    ) {
        let endpoint = APIConfiguration.Endpoint.listPhotos(page: page, perPage: perPage)
        
        NetworkService.shared.request(endpoint: endpoint) { (result: Result<[UnsplashPhoto], NetworkError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func searchPhotos( ///Default per page is 20
        query: String,
        page: Int = 1,
        perPage: Int = 20,
        completion: @escaping (Result<SearchResult, NetworkError>) -> Void
    ) {
        let endpoint = APIConfiguration.Endpoint.searchPhotos(query: query, page: page, perPage: perPage)
        
        NetworkService.shared.request(endpoint: endpoint) { (result: Result<SearchResult, NetworkError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
