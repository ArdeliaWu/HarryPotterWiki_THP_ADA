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
    
    private let networkService = NetworkService.shared
    
    // Fetch all books
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: APIResponse<Movie> = try await networkService.fetchList(
                endpoint: "/movies",
                queryParameters: [
                    "page[number]" : "1",
                    "page[size]": "25",
                ]
            )
            
            movies = response.data ?? []
            
        } catch let error as NetworkError {
            errorMessage = error.message
        } catch {
            errorMessage = "An unexpected error occurred"
        }
        
        isLoading = false
    }
}
