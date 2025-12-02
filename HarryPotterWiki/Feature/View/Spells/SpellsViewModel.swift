//
//  SpellsViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation
import Combine

@MainActor
class SpellsViewModel: ObservableObject {
    @Published var spells: [Spell] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchSpells() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Spell> = try await networkService.fetchList(
                endpoint: "/spells",
                queryParameters: [
                    "page[number]" : "1",
                    "page[size]": "25",
                ]
            )
            
            spells = response.data ?? []
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
