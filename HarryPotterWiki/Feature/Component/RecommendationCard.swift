//
//  RecommendationCard.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 03/12/25.
//

import SwiftUI


enum RecommendationItem: Identifiable {
    case book(Book)
    case movie(Movie)
    
    var id: String {
        switch self {
        case .book(let book):
            return "book-\(book.id)"
        case .movie(let movie):
            return "movie-\(movie.id)"
        }
    }
}

struct RecommendationCard: View {
    let item: RecommendationItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image with badge
            ZStack(alignment: .topTrailing) {
                // Poster/Cover
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure, .empty:
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                            Image(systemName: iconName)
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 180, height: 270)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                
                // Badge (Book or Movie)
                HStack(spacing: 4) {
                    Image(systemName: badgeIcon)
                        .font(.caption2)
                    Text(badgeText)
                        .font(.caption2)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(badgeColor)
                .clipShape(Capsule())
                .padding(8)
            }
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: detailIcon)
                        .font(.caption2)
                    Text(detailText)
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
            }
            .frame(width: 180, alignment: .leading)
        }
    }
    
    
    private var imageURL: URL? {
        switch item {
        case .book(let book):
            return URL(string: book.attributes.cover ?? "")
        case .movie(let movie):
            return URL(string: movie.attributes.poster ?? "")
        }
    }
    
    private var iconName: String {
        switch item {
        case .book: return "book.closed.fill"
        case .movie: return "film.fill"
        }
    }
    
    private var badgeIcon: String {
        switch item {
        case .book: return "book.fill"
        case .movie: return "film.fill"
        }
    }
    
    private var badgeText: String {
        switch item {
        case .book: return "Book"
        case .movie: return "Movie"
        }
    }
    
    private var badgeColor: Color {
        switch item {
        case .book: return .blue
        case .movie: return .purple
        }
    }
    
    private var title: String {
        switch item {
        case .book(let book):
            return book.attributes.title ?? "Unknown"
        case .movie(let movie):
            return movie.attributes.title ?? "Unknown"
        }
    }
    
    private var subtitle: String {
        switch item {
        case .book(let book):
            return book.attributes.author ?? "Unknown Author"
        case .movie(let movie):
            return movie.attributes.releaseDate ?? "Unknown Date"
        }
    }
    
    private var detailIcon: String {
        switch item {
        case .book: return "doc.text.fill"
        case .movie: return "clock.fill"
        }
    }
    
    private var detailText: String {
        switch item {
        case .book(let book):
            if let pages = book.attributes.pages {
                return "\(pages) pages"
            }
            return "Book"
        case .movie(let movie):
            return movie.attributes.runningTime ?? "Movie"
        }
    }
}

