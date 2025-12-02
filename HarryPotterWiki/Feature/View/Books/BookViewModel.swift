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
    @Published var currentPage = 1
    @Published var hasMorePages = true
    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchBooks(
        page: Int = 1,
        pageSize: Int = 25,
    ) async {
        isLoading = true
        errorMessage = nil
        
        var queryParams: [String: String] = [
            "page[number]" : "\(page)",
            "page[size]" : "\(pageSize)"
        ]
        
        do {
            let response: APIResponse<Book> = try await networkService.fetchList(
                endpoint: "/books",//or from: .books,
                queryParameters: queryParams
                
            )
            
            if page == 1{
                books = response.data ?? []
            } else {
                books.append(contentsOf: response.data ?? [])
            }
            
            currentPage = page
            hasMorePages = response.links?.next != nil
           
            
            if let pagination = response.meta? .pagination{
                print("Page \(pagination.current ?? 1) of \(pagination.last ?? 1)")
                print("Total books: \(pagination.records ?? 0)")
                
                
            }
            
        } catch let error as NetworkError {
            errorMessage = error.message
            print("Error : \(error.message)")
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
    
    func loadMoreBooks() async {
        guard hasMorePages, !isLoading else { return }
        await fetchBooks(page: currentPage + 1)
    }
}
