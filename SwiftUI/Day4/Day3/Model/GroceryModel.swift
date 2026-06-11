//
//  Grocery.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import Foundation
import SwiftData

@Model
class GroceryModel: Identifiable{
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
