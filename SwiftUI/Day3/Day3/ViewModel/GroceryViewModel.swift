//
//  GroceryViewModel.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import Foundation
import Combine
import SwiftUI

class GroceryViewModel: ObservableObject{
    @Published var groceries: [GroceryModel] = []
    
    func addGrocery(name: String){
        let newGrocery = GroceryModel(name: name)
        groceries.append(newGrocery)
    }
    
    func removeGrocery(at offsets: IndexSet){
        groceries.remove(atOffsets: offsets)
    }
    
}
