//
//  ChapterView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import SwiftUI

struct ChaptersListView: View {
    let book: Book
    @StateObject private var viewModel = ChaptersViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading chapters...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.chapters.isEmpty {
                ContentUnavailableView(
                    "No Chapters Found",
                    systemImage: "list.bullet.rectangle",
                    description: Text("Unable to load chapters for this book")
                )
            } else {
                List(viewModel.chapters) { chapter in
                    ChapterRowView(chapter: chapter)
                }
            }
        }
        .navigationTitle(book.attributes.title ?? "Chapters")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchChapters(bookId: book.id)
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

struct ChapterRowView: View {
    let chapter: Chapter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Chapter number and title
            HStack {
                if let order = chapter.attributes.order {
                    Text("Chapter \(order)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                
                Spacer()
            }
            
            if let title = chapter.attributes.title {
                Text(title)
                    .font(.headline)
            }
            
            // Chapter summary
            if let summary = chapter.attributes.summary, !summary.isEmpty {
                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 4)
    }
}
