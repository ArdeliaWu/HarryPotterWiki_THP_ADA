//
//  CharacterDetailView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with image
                if let imageURL = character.attributes.image,
                   let url = URL(string: imageURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Basic Info
                    if let born = character.attributes.born {
                        DetailRow(label: "Born", value: born)
                    }
                    
                    if let died = character.attributes.died {
                        DetailRow(label: "Died", value: died)
                    }
                    
                    if let species = character.attributes.species {
                        DetailRow(label: "Species", value: species)
                    }
                    
                    if let house = character.attributes.house {
                        DetailRow(label: "House", value: house)
                    }
                    
                    if let patronus = character.attributes.patronus {
                        DetailRow(label: "Patronus", value: patronus)
                    }
                    
                    if let bloodStatus = character.attributes.bloodStatus {
                        DetailRow(label: "Blood Status", value: bloodStatus)
                    }
                    
                    // Array fields
                    if let alias = character.attributes.alias, !alias.isEmpty {
                        DetailSection(label: "Aliases", items: alias)
                    }
                    
                    if let jobs = character.attributes.jobs, !jobs.isEmpty {
                        DetailSection(label: "Jobs", items: jobs)
                    }
                    
                    if let titles = character.attributes.titles, !titles.isEmpty {
                        DetailSection(label: "Titles", items: titles)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(character.attributes.name ?? "Character")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
    }
}

struct DetailSection: View {
    let label: String
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            
            ForEach(items, id: \.self) { item in
                Text("• \(item)")
                    .font(.body)
            }
        }
    }
}
