//
//  AddGroceryHeaderView.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftUI

struct AddGroceryHeaderView: View {
    
    @ObservedObject var viewModel : GroceryViewModel
    @State private var newGrocery: String = ""
    var body: some View {
        HStack{
            TextField("Enter the Grocery name", text: $newGrocery)
            Button("+"){
                if !newGrocery.isEmpty{
                    viewModel.addGrocery(name: newGrocery)
                    newGrocery = ""
                }
            }
        }.padding()
    }
}

#Preview {
    AddGroceryHeaderView(viewModel: GroceryViewModel())
}
