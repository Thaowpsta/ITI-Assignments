//
//  AddGroceryHeaderView.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftUI

struct AddGroceryHeaderView: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel : GroceryViewModel
    @State var newGrocery: String = ""

    var body: some View {
        HStack{
            TextField("Enter the Grocery name", text: $newGrocery)
                .onSubmit {
                    viewModel.addGrocery(name: newGrocery, modelContext: modelContext)
                    newGrocery = ""
                }
            Button("+"){
                if !newGrocery.isEmpty{
                    viewModel.addGrocery(name: newGrocery, modelContext: modelContext)
                    newGrocery = ""
                }
            }.disabled(newGrocery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }.padding()
    }
}

#Preview {
    AddGroceryHeaderView(viewModel: GroceryViewModel())
}
