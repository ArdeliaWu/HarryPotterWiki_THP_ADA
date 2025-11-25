//
//  CharactersViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation
import Combine

@MainActor
class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentPage = 1
    @Published var hasMorePages = true
    
    private let networkService = NetworkService.shared
    
    // Fetch characters with optional filtering
    func fetchCharacters(
        page: Int = 1,
        pageSize: Int = 25,
        nameFilter: String? = nil
    ) async {
        isLoading = true
        errorMessage = nil
        
        var queryParams: [String: String] = [
            "page[number]": "\(page)",
            "page[size]": "\(pageSize)"
        ]
        
        // Add filter if provided
        if let name = nameFilter, !name.isEmpty {
            queryParams["filter[name_cont]"] = name
        }
        
        do {
            let response: APIResponse<Character> = try await networkService.fetchList(
                endpoint: "/characters",
                queryParameters: queryParams
            )
            
            if page == 1 {
                characters = response.data ?? []
            } else {
                characters.append(contentsOf: response.data ?? [])
            }
            
            currentPage = page
            hasMorePages = response.links?.next != nil
            
        } catch {
            errorMessage = "Failed to load characters: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // Fetch next page
    func loadMoreCharacters() async {
        guard hasMorePages, !isLoading else { return }
        await fetchCharacters(page: currentPage + 1)
    }
    
    // Search characters by name
    func searchCharacters(name: String) async {
        await fetchCharacters(page: 1, nameFilter: name)
    }
}
