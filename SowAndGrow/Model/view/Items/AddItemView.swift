//
//  AddItemView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import SwiftUI
import SwiftData

struct AddItemView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var item: Item
 //   @Bindable var favorite: Favorite
    
    @State private var showAlert = false //alert used if no Task is selected: LOC: 67
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Pflanze"){
                    TextField("Name eingeben", text: $item.name)
                        .disableAutocorrection(true)
                    TextField("Pflanzentyp (optional)", text: $item.typeOfPlant)
                        .disableAutocorrection(true)
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
                Section("Pflanze zur Favoritenliste hinzufügen") {
                    Toggle("Favorit", isOn: $item.isFavorite)
                        .tint(.accentColor)
                }
                
                
                if(item.name.isEmpty) {
                    Button(action:  {
                    })
                    {
                        Text("Speichern")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(7)
                            .disabled(item.name.isEmpty)
                    }
                    .listRowBackground(Color.clear)
                }
                else {
                    Button(action:  {
                         if(item.task == .choose) {
                            showAlert = true
                         } else {
                             addItem()
                             dismiss()
                         }
                    })
                    {
                        Text("Speichern")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(7)
                            .disabled(item.name.isEmpty)
                    }
                    .listRowBackground(Color.clear)
                }
                
                //removes all User input, resets everything
                Button(action: {
                    item.name = ""
                    item.typeOfPlant = ""
                    item.priority = false
                    item.isFavorite = false
                    item.date = Date.now
                }) {
                    Text("Eingabe zurücksetzen")
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            
            }
            .scrollContentBackground(.hidden) //modifier is needed to set custom BackgroundColor
            .background(Color(red: 245/255, green: 245/255, blue: 245/255))
            
            .toolbar {
                ToolbarItem(placement: .bottomBar) //to anchor the button to the bottom of the View
                {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("schliessen")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .bottom)
                            .padding(.bottom)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
       
        // if no task is selected when pressing the save button, this alert will be triggered
           .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Fehlende Angaben!"),
                    message: Text("Bitte wähle eine Aufgabe aus dem Dropdown aus.")
                )
            }
        }
           
      //  .navigationTitle("Aufgabe erstellen")
      //  .navigationBarTitleDisplayMode(.inline)
    }
    // adds the new Item to the Model Context
    func addItem() {
        modelContext.insert(item)
        //   path.append(item)
        //  path = [item]
        
        // if an Item is marked as Favorite a new Favorite Object is created, asinging the values of name and typeOfPlant from the Item Object to the new Favorite Object...
        if (item.isFavorite == true) {
            let fav = Favorite(name: item.name, typeOfPlant: item.typeOfPlant)
            //, isFavorite: item.isFavorite)
                modelContext.insert(fav)
            
          //  item.hasFavorite.append(fav)
            /*
             let favorite = Favorite(name: item.name, typeOfPlant: item.typeOfPlant)
             modelContext.insert(favorite)
             } */
        }
    }
}
/*
#Preview {
    AddItemView()
}
*/
