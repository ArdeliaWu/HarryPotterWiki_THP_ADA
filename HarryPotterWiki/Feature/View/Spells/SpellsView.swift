//
//  SpellsView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 02/12/25.
//

import SwiftUI

struct SpellsView: View {
    @StateObject private var viewModel = SpellsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading && viewModel.spells.isEmpty {
                    ProgressView("Loading spells...")
                } else if viewModel.spells.isEmpty {
                    ContentUnavailableView(
                        "No Spells Found",
                        systemImage: "wand.and.stars"
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.spells) { spell in
                                SpellRowView(spell: spell)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Spells")
            .task {
                if viewModel.spells.isEmpty {
                    await viewModel.fetchSpells()
                }
            }
        }
    }
}

struct SpellRowView: View {
    let spell: Spell
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(spell.attributes.name ?? "Unknown Spell")
                .font(.headline)
            
            if let incantation = spell.attributes.incantation {
                Text("\(incantation)")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
            }
            
            if let effect = spell.attributes.effect {
                Text(effect)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    SpellsView()
}
