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
            Group {
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    ProgressView("Loading movies...")
                } else if viewModel.movies.isEmpty {
                    ContentUnavailableView(
                        "No Movies Found",
                        systemImage: "film"
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.movies) { movie in
                                MovieRowView(movie: movie)
                                
                                if movie.id == viewModel.movies.last?.id {
                                    if viewModel.hasMorePages {
                                        ProgressView()
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .task {
                                                await viewModel.loadMoreMovies()
                                            }
                                    }
                                }
                            }
                            
                            
                        }
                        .padding()
                        
                        
                    }
                }
            }
            .navigationTitle("Movies")
            .task {
                if viewModel.movies.isEmpty {
                    await viewModel.fetchMovies()
                }
            }
        }
    }
}

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: movie.attributes.poster ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().aspectRatio(contentMode: .fill)
                case .failure, .empty:
                    Image(systemName: "film.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 60, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.attributes.title ?? "Untitled")
                    .font(.headline)
                    .lineLimit(2)
                
                if let releaseDate = movie.attributes.releaseDate {
                    Text(releaseDate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let runtime = movie.attributes.runningTime {
                    Text(runtime)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    MoviesView()
}
