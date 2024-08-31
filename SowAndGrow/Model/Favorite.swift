//
//  Favorite.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 02.07.24.
//

import Foundation
import SwiftData

@Model
class Favorite {
    var id = UUID()
    @Attribute(.unique) var name: String //no duplicates allowed
    var typeOfPlant: String
    var isFavorite: Bool


    init(id: UUID = UUID(), name: String = "", typeOfPlant: String = "", isFavorite: Bool = true ) {
        self.id = id
        self.name = name
        self.typeOfPlant = typeOfPlant
        self.isFavorite = isFavorite
    }
}
