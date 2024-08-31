//
//  Item.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 25.06.24.
//

import Foundation
import SwiftData


@Model
class Item {
    var id = UUID()
    var name: String
    var typeOfPlant: String
    var task: Task
    var priority: Bool
    var isDone: Bool // needed to apply custom color and "checkmark" Icon when task is moved to "Erledigt", as well as to show text-button with option to move task back to "Offen".
    var date: Date
    var isFavorite: Bool // if set to true, new Object of Type Favorite will be created
    
    
    init(id: UUID = UUID(), name: String = "", typeOfPlant: String = "", task: Task = .choose, priority: Bool = false, isDone: Bool = false , date: Date = .now, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.typeOfPlant = typeOfPlant
        self.task = task
        self.priority = priority
        self.isDone = isDone
        self.date = date
        self.isFavorite = isFavorite
    }
}

enum Task: String, Codable, CaseIterable, Identifiable {
    var id: Self {self}
    case choose = "Wähle eine Aktion"
    case plant = "Auspflanzen"
    case sow = "Aussäen"
    case fertilize = "Düngen"
    case harvest = "Ernten"
    case water = "Giessen"
    case buy = "Kaufen"
    case prick = "Pikieren"
}
