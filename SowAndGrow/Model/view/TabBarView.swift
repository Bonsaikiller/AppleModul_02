//
//  TabBarView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
  
  //@Environment(\.modelContext) var modelContext
    // Query Macro is needed to count the current amount of Item/Favorite Objects and display their number in the badges
    @Query var item: [Item]
    @Query var favorite: [Favorite]

    // Since the AddItem Tab is implemented by the use of isPresented as .sheet, these settings are necessary to redirect the User, when finished with adding an Item, to the last used Tab (either the ListView oder FavoriteView). Otherwise he'd be stuck with the AddItemView: onChange Function LOC: 50
    @State private var tagSelection = 1
    @State private var oldSelection = 1
    @State private var sheetIsPresented = false
    
    var body: some View {
        
        //  Only the number of open tasks should be displayed in the badge. used .filter to count specific items where .isDone is true to substract them from the overall item.count
        
        let countDoneItems = item.filter(\.isDone).count
        let itemsToDo = item.count - countDoneItems
        
        TabView(selection: $tagSelection){
            ItemListView(favorite: Favorite(name: ""))
                .tabItem {
                    Label("Aufgaben", systemImage: "list.bullet.clipboard.fill")}
              .tag(1) // the tags are necessary for the onChange function
            .badge(itemsToDo)
            
              Text("")
                .tabItem {
                    Label("Aufgabe", systemImage: "plus.circle.fill" ) }
                .tag(2)
                
            
            FavoriteListView(item: Item(name: ""))
                .tabItem {
                    Label("Favoriten", systemImage: "heart" ) }
              .tag(3)
                 .badge(favorite.count)
        } 
        
        // deprecated in iOs17: didn't understand "Use onChange with a two or zero parameter action closure instead." "deprecated" - Warning only shows up when $0 is used on oldSelection
        .onChange(of: tagSelection) {
          if tagSelection == 2 {
                self.sheetIsPresented = true
             self.tagSelection = self.oldSelection // if not set, an empty View will be displayed under the AddItemView - therefore tagSelection is set to oldSelection and the last used View will be visible in the back or if the sheet gets dragged down
          } else if (sheetIsPresented == false){
              self.oldSelection = $0
          }
        }
            .sheet(isPresented: $sheetIsPresented, onDismiss: {
               //  self.tagSelection = self.oldSelection  //not sure about this one. seems to work as well if code is not used
            })  { 
                AddItemView(item: Item(name: ""))
        }
    }
}

/*
 #Preview {
 TabBarView()
 }
 */
