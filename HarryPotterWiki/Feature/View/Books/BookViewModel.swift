//
//  BookViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation
import Combine

@MainActor
class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchBooks() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Book> = try await networkService.fetchList(
                endpoint: "/books"
            )
            
            books = response.data ?? []
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
