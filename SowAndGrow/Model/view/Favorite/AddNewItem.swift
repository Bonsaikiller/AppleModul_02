//
//  AddNewItem.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 02.07.24.
//

import SwiftUI
import SwiftData

struct AddNewItem: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var favorite: Favorite
    @Bindable var item: Item
    
    var body: some View {
        
        
            List {
                Section("Pflanze"){
                    TextField("", text: $favorite.name)
                    TextField("", text: $favorite.typeOfPlant)
                }
                
                Section("Was ist zu tun?"){
                    Picker("Aufgabe", selection: $item.task) {
                        ForEach(Task.allCases, id: \.self) { task in
                            Text(task.rawValue)
                        }
                        .pickerStyle(.menu)
                    }
                }
                Section("Wähle Dringlichkeit und Zeit") {
                    Toggle("Dringend", isOn: $item.priority)
                        .tint(.accentColor)
                    DatePicker("Fällig", selection: $item.date, in: Date.now..., displayedComponents: .date)
                        .tint(.accentColor)
                }
                Button(action:  {
                    addItem()
                    dismiss()
                }) {
                    Text("neue Aufgabe erstellen")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                        .disabled(item.task == .choose)
                }
                .listRowBackground(Color.clear)
                
                Button(action: {
                    item.priority = false
                    item.task = .plant
                    item.date = Date.now
                    dismiss()
                }) {
                    Text("abbrechen")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Neue Aufgabe erstellen")
            .navigationBarTitleDisplayMode(.inline)
    }

 func addItem() {
     let newItem = Item(name: favorite.name, typeOfPlant: favorite.typeOfPlant, task: item.task, priority: item.priority, date: item.date,isFavorite: true)
         modelContext.insert(newItem)

   /*  if(item.isFavorite == true) {
         let newFav = Favorite(name: item.name, typeOfPlant: item.typeOfPlant)
         modelContext.insert(newFav)
     } */
    }
 }

/*
 #Preview {
   AddNewItem()
}
 */
