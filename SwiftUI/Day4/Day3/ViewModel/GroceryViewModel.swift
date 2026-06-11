//
//  GroceryViewModel.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

class GroceryViewModel: ObservableObject{
    @Published var groceries: [GroceryModel] = []
    
    func addGrocery(name: String, modelContext: ModelContext){
        _ = GroceryModel(name: name)
        modelContext.insert(GroceryModel(name: name))
    }
    
    func removeGrocery(item: GroceryModel, modelContext: ModelContext){
        modelContext.delete(item)
    }
    
}
