//
//  BookView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import SwiftUI
import Combine

struct BooksView: View {
    @StateObject private var viewModel = BooksViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading books...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.books.isEmpty {
                    ContentUnavailableView(
                        "No Books Found",
                        systemImage: "book.closed",
                        description: Text("Unable to load Harry Potter books")
                    )
                } else {
                    List(viewModel.books) { book in
                        NavigationLink(value: book) {
                            BookRowView(book: book)
                        }
                    }
                }
            }
            .navigationTitle("Harry Potter Books")
            .navigationDestination(for: Book.self) { book in
                ChaptersListView(book: book)
            }
            .task {
                await viewModel.fetchBooks()
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

struct BookRowView: View {
    let book: Book
    
    var body: some View {
        HStack(spacing: 12) {
            // Book cover image
            AsyncImage(url: URL(string: book.attributes.cover ?? "")) { phase in
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
                Text(book.attributes.title ?? "Untitled")
                    .font(.headline)
                    .lineLimit(2)
                
                if let author = book.attributes.author {
                    Text(author)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let pages = book.attributes.pages {
                    Text("\(pages) pages")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                if let releaseDate = book.attributes.releaseDate {
                    Text(releaseDate)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
