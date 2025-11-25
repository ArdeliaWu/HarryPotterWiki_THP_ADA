//
//  ChapterViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation
import Combine

@MainActor
class ChaptersViewModel: ObservableObject {
    @Published var chapters: [Chapter] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    // Fetch chapters for a specific book
    func fetchChapters(bookId: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Chapter> = try await networkService.fetchList(
                endpoint: "/books/\(bookId)/chapters"
            )
            
            chapters = response.data ?? []
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
