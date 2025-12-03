//
//  HomePageView.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        ZStack {
            BooksView()
            
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
