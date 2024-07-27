//
//  SowAndGrowApp.swift
//  SowAndGrow
//
//  Created by Susanne Dvorak on 02.07.24.
//

import SwiftUI
import SwiftData

@main
struct SowAndGrowApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
             //   .modelContainer(for: Item.self)
             .modelContainer(for: [Item.self, Favorite.self])
        }
    }
}
