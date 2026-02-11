//
//  HomePageView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            BooksView()
            
//            if viewModel.isLoading {
//                RecommendationLoading()
//            } else if !viewModel.recommendations.isEmpty {
//                VStack(alignment: .leading, spacing: 12) {
//                    HStack {
//                        Image(systemName: "star.fill")
//                            .foregroundStyle(.yellow)
//                        Text("Today's Recommendations")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 16) {
//                            ForEach(viewModel.recommendations) { recommendation in
//                                switch recommendation {
//                                case .book(let book):
//                                    NavigationLink(value: book) {
//                                        RecommendationCard(item: recommendation)
//                                    }
//                                    .buttonStyle(.plain)
//                                    
//                                case .movie(let movie):
//                                    RecommendationCard(item: recommendation)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//            }
            
            TabView{
                Tab("Books", systemImage: "book"){
                    BooksView()
                }
                Tab("Characters", systemImage: "person.3"){
                    CharacterListView()
                }
                Tab("Movies", systemImage: "film"){
                    MoviesView()
                }
                Tab("Potions", systemImage: "flask"){
                    PotionsView()
                }
                Tab("Spells", systemImage: "wand.and.sparkles"){
                    SpellsView()
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
}
