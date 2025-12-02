//
//  MoviesView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 02/12/25.
//

import SwiftUI

import Combine

struct MoviesView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
//            TestNetworkView()
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading movie...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.movies.isEmpty {
                    ContentUnavailableView(
                        "No Movies Found",
                        systemImage: "book.closed",
                        description: Text("Unable to load Harry Potter books")
                    )
                } else {
                    List(viewModel.movies) { movie in
                        NavigationLink(value: movie) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Harry Potter Books")
//            .navigationDestination(for: movie.self) { book in
//                ChaptersListView(book: book)
//            }
            .task {
                await viewModel.fetchMovies()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            // Book cover image
            AsyncImage(url: URL(string: movie.attributes.poster ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 90)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "book.closed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 90)
                        .foregroundStyle(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            // Book info
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.attributes.title ?? "Untitled")
                    .font(.headline)
                    .lineLimit(2)
                
                if let runningTime = movie.attributes.runningTime {
                    Text(runningTime)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let summary = movie.attributes.summary {
                    Text(summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
//                if let releaseDate = movie.attributes.releaseDate {
//                    Date(releaseDate)
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct TestMovieNetworkView: View {
    var body: some View {
        VStack {
            Button("Test Fetch Movies") {
                Task {
                    await testFetchMovies()
                }
            }
        }
    }
    
    func testFetchMovies() async {
        do {
            let response: APIResponse<Book> = try await NetworkService.shared.fetchList(endpoint: "/movies")
            print("✅ Success! Got \(response.data?.count ?? 0) movies")
            
            if let firstMovie = response.data?.first {
                print("📚 First movies: \(firstMovie.attributes.title ?? "Unknown")")
            }
            
        } catch let error as NetworkError {
            print("❌ Error: \(error.message)")
        } catch {
            print("❌ Unexpected error: \(error)")
        }
    }
}
