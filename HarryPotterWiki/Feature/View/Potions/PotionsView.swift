//
//  PotionsView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 02/12/25.
//

import SwiftUI

struct PotionsView: View {
    @StateObject private var viewModel = PotionsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading && viewModel.potions.isEmpty {
                    ProgressView("Loading potions...")
                } else if viewModel.potions.isEmpty {
                    ContentUnavailableView(
                        "No Potions Found",
                        systemImage: "flask"
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.potions) { potion in
                                PotionRowView(potion: potion)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Potions")
            .task {
                if viewModel.potions.isEmpty {
                    await viewModel.fetchPotions()
                }
            }
        }
    }
}

struct PotionRowView: View {
    let potion: Potion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(potion.attributes.name ?? "Unknown Potion")
                .font(.headline)
            
            if let effect = potion.attributes.effect {
                Text(effect)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            if let difficulty = potion.attributes.difficulty {
                HStack {
                    Image(systemName: "chart.bar.fill")
                        .font(.caption)
                    Text(difficulty)
                        .font(.caption)
                }
                .foregroundStyle(.blue)
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
    PotionsView()
}
