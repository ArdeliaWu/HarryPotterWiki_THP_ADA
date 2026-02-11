//
//  HomePageViewModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recommendations: [RecommendationItem] = []
    @Published var isLoading = false
    
    private let networkService = NetworkService.shared
    
    
    func loadRecommendations() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchMixedRecommendations() }
        }
    }
    
    func refreshRecommendations() async {
        await loadRecommendations()
    }
    
    private func fetchMixedRecommendations() async {
        isLoading = true
        
        do {
            // Fetch books
            let booksResponse: APIResponse<Book> = try await networkService.fetchList(
                endpoint: "/books"
            )
            let books = booksResponse.data ?? []
            
            // Fetch movies
            let moviesResponse: APIResponse<Movie> = try await networkService.fetchList(
                endpoint: "/movies"
            )
            let movies = moviesResponse.data ?? []
            
            // Mix books and movies
            var mixed: [RecommendationItem] = []
            
            // Add random 3 books
            let randomBooks = books.shuffled().prefix(3)
            mixed.append(contentsOf: randomBooks.map { .book($0) })
            
            // Add random 3 movies
            let randomMovies = movies.shuffled().prefix(3)
            mixed.append(contentsOf: randomMovies.map { .movie($0) })
            
            // Shuffle the mixed array so books and movies are interleaved randomly
            recommendations = mixed.shuffled()
            
        } catch {
            print(" Error fetching recommendations: \(error)")
        }
        
        isLoading = false
    }
}

