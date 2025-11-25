//
//  PotterAPIService.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

final class PotterAPIService{
    private let client: NetworkClient
    
    init(client: NetworkClient = URLSessionNetworkClient()) {
        self.client = client
    }
    
    func fetchCharacters(page: Int = 1, size: Int = 25, filter: String? = nil, sort: String? = nil)
    async throws -> JSONAPIListResponse<CharacterResource> {
        let url = PotterEndpoint.characters(page: page, size: size, filterNameContains: filter, sort: sort).url
        return try await client.get(url, as: JSONAPIListResponse<CharacterResource>.self)
    }
    
    func fetchCharacter(identifier: String) asnyc throws -> JSONAPISingleResponse<CharacterResource> {
        let url = PotterEndpoint.character(identifier: identifier).url
        return try await client.get(url, as: JSONAPISingleResponse<CharacterResource>.self)
    }
}
            
