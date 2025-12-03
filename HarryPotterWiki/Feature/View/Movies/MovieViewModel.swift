//
//  MovieViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation
import Combine

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentPage = 1
    @Published var hasMorePages = true

    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchMovies(
        page: Int = 1,
        pageSize: Int = 50
    ) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Movie> = try await networkService.fetchList(
                endpoint: "/movies",
                queryParameters: [
                    "page[number]" : "\(page)",
                    "page[size]": "\(pageSize)",
                ]
            )
            
            if page == 1{
                movies = response.data ?? []
            } else {
                movies.append(contentsOf: response.data ?? [])
            }
            
            currentPage = page
            hasMorePages = response.links?.next != nil
            
            if let pagination = response.meta? .pagination{
                print("Page \(pagination.current ?? 1) of \(pagination.last ?? 1)")
                print("Total movies: \(pagination.records ?? 0)")
            }
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
    
    func loadMoreMovies() async {
        guard !isLoading, hasMorePages else { return }
        await fetchMovies(page: currentPage + 1)
    }
}
