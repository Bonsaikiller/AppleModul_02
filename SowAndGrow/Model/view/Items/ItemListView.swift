//
//  ItemListView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import SwiftUI
import SwiftData

struct ItemListView: View {
    
  @Environment(\.modelContext) var modelContext
  @State private var path = [Item]() //path = an Array of Tasks
    
  //tried to create a sorting by date and priority, but no bools allowed
    @Query(sort: [SortDescriptor (\Item.date),
              SortDescriptor (\Item.name)]) var item: [Item]
    var favorite: Favorite
    
    @State private var showHelp = false 
    
    var body: some View {

        NavigationStack(path: $path) {
            
            //contentunavailable-code taken from "CRUD-Operations" Tutorial by Stewart Lynch: www.youtube.com/@StewartLynch. 
            if item.isEmpty {
                ContentUnavailableView("Erstelle mit dem Plus in der Tabbar eine Aufgabe.", systemImage: "plus")
            } else {
                List {
                    Section(header: Text("Offen")) {
                        ForEach(item) { item in
                            if (item.isDone == false) {  //displays only the todo-items
                                SingleItemView(item: item)
                                    .swipeActions(edge: .leading) {   //swipe from left to right to mark as done
                                        Button {
                                            item.isDone = true
                                        } label: {
                                            Label("Fertig", systemImage: "checkmark")
                                                    .tint(.accentColor)
                                        }
                                    }
                            }
                        }
                        .onDelete(perform: deleteItem(_:))
                    }
                    .headerProminence(.increased)
                    
                    Section(header: Text("Erledigt")) {
                        ForEach(item) { item in
                            if (item.isDone == true) {   //displays items marked as done
                                SingleItemView(item: item)
                            }
                        }
                        .onDelete(perform: deleteItem(_:))
                    }

                    .headerProminence(.increased)
                }
                .scrollContentBackground(.hidden) // is needed to set custom background
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                .listStyle(.insetGrouped)
                .navigationBarTitle("Aufgaben")
                .navigationDestination(for: Item.self) {item in EditItemView(item: item, favorite: favorite)}
                
                .toolbar {
                    Button {
                        showHelp.toggle() //when activated displays the helpview as .sheet
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
            let item = item[index]
            modelContext.delete(item)
        }
    }
}
    
/*
 #Preview {
 ItemListView()
 }
*/
   

