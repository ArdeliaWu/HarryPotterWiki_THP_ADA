//
//  Network.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

enum NetworkError : Error {
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
    case other(Error)
}

protocol NetworkClient{
    func get<T: Decodable> (_ url: URL, as type: T.Type) async throws -> T
}

final class URLSessionNetworkClient: NetworkClient{
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    func get<T>(_ url: URL, as type: T.Type) async throws -> T where T : Decodable {
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200...299).contains(http.statusCode) else {
                throw NetworkError.statusCode(http.statusCode)
            }
            do{
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw NetworkError.decoding(error)
            }
            
        }catch{
            throw NetworkError.other(error)
        }
    }
    
}
