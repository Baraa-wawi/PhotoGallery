//
//  APIConfiguration.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import Foundation

struct APIConfiguration {
    static let baseURL = "https://api.unsplash.com"
    static let accessKey = "O0Jqsq5BPCzQewAXAZlVpBGDjzsj4H32Q7BkCP2xUWE"
    
    enum Endpoint {
        case listPhotos(page: Int, perPage: Int)
        case searchPhotos(query: String, page: Int, perPage: Int)
        
        var path: String {
            switch self {
            case .listPhotos:
                return "/photos"
            case .searchPhotos:
                return "/search/photos"
            }
        }
        
        func url() -> URL? {
            var components = URLComponents(string: APIConfiguration.baseURL + path)
            components?.queryItems = queryItems()
            return components?.url
        }
        
        private func queryItems() -> [URLQueryItem] {
            switch self {
            case .listPhotos(let page, let perPage):
                return [
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "per_page", value: "\(perPage)")
                ]
            case .searchPhotos(let query, let page, let perPage):
                return [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "per_page", value: "\(perPage)")
                ]
            }
        }
    }
}
