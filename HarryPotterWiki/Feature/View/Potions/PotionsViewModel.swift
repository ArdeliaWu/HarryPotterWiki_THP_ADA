//
//  PotionsViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation
import Combine

@MainActor
class PotionsViewModel: ObservableObject {
    @Published var potions: [Potion] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchPotions() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Potion> = try await networkService.fetchList(
                endpoint: "/potions",
                queryParameters: [
                    "page[number]" : "1",
                    "page[size]": "25",
                ]
            )
            
            potions = response.data ?? []
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
