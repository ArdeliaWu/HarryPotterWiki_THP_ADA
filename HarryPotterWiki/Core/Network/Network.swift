//
//  Network.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Failed to decode: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://api.potterdb.com/v1"
    
    private init() {}
    
  
    func fetchList<T: Codable>(
        endpoint: String,
        queryParameters: [String: String] = [:]
    ) async throws -> APIResponse<T> {
        
        var components = URLComponents(string: baseURL + endpoint)
        if !queryParameters.isEmpty {
            components?.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError(statusCode: 0)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        // Decode JSON
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(APIResponse<T>.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func fetchSingle<T: Codable>(
        endpoint: String
    ) async throws -> SingleAPIResponse<T> {
        
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: 0)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(SingleAPIResponse<T>.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
