//
//  EditItemView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 26.06.24.
//

import SwiftUI
import SwiftData

struct EditItemView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var item: Item // two way Binding to read and display updated content
    @Bindable var favorite: Favorite
//  var favorite: Favorite
    var body: some View {
        
        List {
            Section("Pflanze"){
                TextField("Name", text: $item.name)
                TextField("Pflanzentyp", text: $item.typeOfPlant)
            }
            Section("Was ist zu tun?"){
                Picker("Aufgabe", selection: $item.task) {
                    ForEach(Task.allCases, id: \.self) { task in
                        Text(task.rawValue)
                    }
                    .pickerStyle(.menu)
                }
            }
            Section("Bearbeite Dringlichkeit und Zeit") {
                Toggle("Dringend", isOn: $item.priority)
                    .tint(.accentColor)
                DatePicker("Fällig", selection: $item.date, in: Date.now..., // no past date allowed,
                           displayedComponents: .date)  // no time displayed
                
                //   Toggle("Favorit", isOn: $item.isFavorite) .tint(.accentColor)
                
            }
            HStack {
                if(item.isFavorite == false) {
                    Button(action:  {
                        item.isFavorite = true
                        addFavorite()
                        //addItem()
                        // dismiss()
                    }) {
                        Text ("Pflanze zu Favoriten hinzufügen")
                            .font(.system(size: 16, weight: .medium))
                            .cornerRadius(7)
                    }
                } else {

                    Button(action:  {
                        
                    }) {
                        Text("Als Favorit gespeichert")
                            .font(.system(size: 16, weight: .medium))
                            .cornerRadius(7)
                            .foregroundColor(.black)
                    }
                }
                Image(systemName:(item.isFavorite ? "heart.fill" : "heart"))
                    .foregroundColor(.accentColor)
            }
                
            if (item.isDone == true){
                Button("In \"Offen\" verschieben") {
                    item.isDone = false
                    dismiss()
                }
                .font(.system(size: 16, weight: .medium))
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
        .navigationTitle("Aufgabe Editieren")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func addFavorite() {
        let fav = Favorite(name: item.name, typeOfPlant: item.typeOfPlant )
        modelContext.insert(fav)
    }
  /*
    func addItem() {
            if(item.isFavorite == true) {
                let fav = Favorite(name: item.name, typeOfPlant: item.typeOfPlant )
                modelContext.insert(fav)
    
                //item.hasFavorite.append(fav)
               /*
                let favorite = Favorite(name: item.name, typeOfPlant: item.typeOfPlant)
                    modelContext.insert(favorite) */
            }
        }
   */
    
    // nice try
/*    func removeFavorite(){
        if((item.isFavorite == false) && (item.name == favorite.name)) {
            favorite.isFavorite = false
        }
       // item.hasFavorite.removeAll()
        } */
    
}

    /*
     #Preview {
     EditItemView()
     }
     */
