//
//  SingleFavoriteView.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 02.07.24.
//

import SwiftUI
import SwiftData

struct SingleFavoriteView: View {
    @Environment(\.modelContext) var modelContext
    let favorite: Favorite
    
    var body: some View {
        NavigationLink(value: favorite) {

            VStack(alignment: .leading) {
                Text(favorite.name)
                    .font(.system(size: 16, weight: .bold))
            }
            if (favorite.typeOfPlant != "") {
                Text(favorite.typeOfPlant)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.accentColor)
            }
        }
    }

}
            /*
 #Preview {
     SingleFavoriteView()
 }
             */
