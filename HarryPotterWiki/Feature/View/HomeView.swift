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
                Tab("Books", systemImage: "text.book.closed.fill"){
                    BooksView()
                }
                Tab("Characters", systemImage: "person.fill"){
                    CharacterListView()
                }
                Tab("Movies", systemImage: "text.book.closed.fill"){
                    MoviesView()
                }
                Tab("Potions", systemImage: "text.book.closed.fill"){
                    PotionsView()
                }
                Tab("Spells", systemImage: "text.book.closed.fill"){
                    SpellsView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
