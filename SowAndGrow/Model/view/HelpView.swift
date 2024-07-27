//
//  HelpView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 08.07.24.
//

import SwiftUI
import SwiftData

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section(header: Text("So nutzt Du \"Aufgaben\":"))  {
                Label {
                    Text("Über das Plus in der Tabbar erstellst Du neue Einträge")
                } icon: {
                    Image(systemName: "plus.circle.fill")
                }
                
                Label {
                    Text("Wische nach Rechts um eine Aufgabe als erledigt zu markieren, nach Links um sie zu löschen")
                } icon: {
                    Image(systemName: "hand.point.up.left.fill")
                }
                
            Label {
                Text("Du kannst erledigte Aufgaben auch wieder zurück in die ToDo's verschieben")
            } icon: {
                Image(systemName: "arrowshape.up.fill")
            }
                Label {
                    Text("Möchtest Du eine Pflanze für weitere Aufgaben speichern, markiere sie als Favorit")
                } icon: {
                    Image(systemName: "heart.fill")
                }
            }   .font(.system(size: 14, weight: .regular))
                .padding(.top,1)

                Section(header: Text("So nutzt Du \"Favoriten\":"))  {
                    Label {
                        Text("Wähle eine Pflanze aus der Favoritenliste um mit eine neue Aufgabe zu erstellen")
                    } icon: {
                        Image(systemName: "plus")
                    }
                    
                    Label {
                        Text("Zum Entfernen der Pflanze aus den Favoriten, wische nach Links")
                    } icon: {
                        Image(systemName: "hand.point.up.left.fill")
                    }
                    
                }  
                .font(.system(size: 14, weight: .regular))
                .padding(.top,1)
    
            Button(action: {
                dismiss()
            }, label: {
                Text("Fenster schliessen")
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding()
            })
        
            .listRowBackground(Color.clear)
            
        }
        .scrollContentBackground(.hidden)
        .background(Color(red: 245/255, green: 245/255, blue: 245/255))

    }
}

#Preview {
    HelpView()
}
