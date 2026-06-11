//
//  Day3App.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftUI
import SwiftData

@main
struct Day3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: GroceryModel.self)
    }
}
