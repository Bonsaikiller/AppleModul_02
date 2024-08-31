//
//  FavoriteListView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Favorite.name) var favorite: [Favorite]
    @State private var path = [Favorite]()
    @State private var showHelp = false
    var item: Item

    
    var body: some View {
        NavigationStack(path: $path) {
            if favorite.isEmpty {
                ContentUnavailableView("Nutze das Herzsymbol in Deiner Aufgabe um diese Pflanze als Favorit zu speichern", systemImage: "heart")
            } else {
                List {
                    Section("") {
                        ForEach(favorite) { favorite in
                                SingleFavoriteView(favorite: favorite)
                        }
                        .onDelete(perform: deleteItem(_:))
                    }
                    .headerProminence(.increased) // increases the Font Size
                }
                .scrollContentBackground(.hidden)
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                .navigationTitle("Favoritenliste")
               // .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Favorite.self) {favorite in
                    AddNewItem(favorite: favorite, item: item) }
                    
                .toolbar {
                     Button {
                      showHelp.toggle() // when activated displays the helpview as .sheet
                     } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    .sheet(isPresented: $showHelp) {
                        HelpView()
                        .presentationDetents([.large])
                    }
                }
            }
        }
    }
    
    func deleteItem(_ indexSet: IndexSet) {
        for index in indexSet {
            let favorite = favorite[index]
            modelContext.delete(favorite)
        }
    }
}
/*
 #Preview {
 FavoriteView()
 }
 */
