//
//  CharacterListView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//
import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharactersViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.characters.isEmpty && !viewModel.isLoading {
                    ContentUnavailableView(
                        "No Characters Found",
                        systemImage: "person.slash",
                        description: Text("Try adjusting your search")
                    )
                } else {
                    List {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(value: character) {
                                CharacterRowView(character: character)
                            }
                        }
                        
                        // Load more when reaching bottom
                        if viewModel.hasMorePages {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .task {
                                    await viewModel.loadMoreCharacters()
                                }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search characters")
                    .onChange(of: searchText) { oldValue, newValue in
                        Task {
                            if newValue.isEmpty {
                                await viewModel.fetchCharacters()
                            } else {
                                await viewModel.searchCharacters(name: newValue)
                            }
                        }
                    }
                }
                
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    ProgressView("Loading characters...")
                }
            }
            .navigationTitle("Potter DB")
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(character: character)
            }
            .task {
                if viewModel.characters.isEmpty {
                    await viewModel.fetchCharacters()
                }
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

struct CharacterRowView: View {
    let character: Character
    
    var body: some View {
        HStack {
            // Placeholder image
            AsyncImage(url: URL(string: character.attributes.image ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(.gray)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.attributes.name ?? "Unknown")
                    .font(.headline)
                
                if let house = character.attributes.house {
                    Text(house)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
