//
//  NetworkService.swift
//  PhotoGallery
//
//  Created by Baraa Wawi on 14/11/2025.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(
        endpoint: APIConfiguration.Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = endpoint.url() else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(APIConfiguration.accessKey)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 401:
                    completion(.failure(.unauthorized))
                    return
                default:
                    completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}

// MARK: - Network Error

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkFailure(Error)
    case unauthorized
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .networkFailure(let error):
            return "Network failure: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized"
        }
    }
}

