//
//  GroceryListView.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftUI

struct GroceryListView: View {

    @ObservedObject var viewModel = GroceryViewModel()
    var body: some View {
        List {
            ForEach(viewModel.groceries, id: \.id) {
                grocery in
                Text(grocery.name)
                    
                    .listRowBackground(Color.mint)
            }
            .onDelete(
                perform: {
                    indexSet in
                    viewModel.removeGrocery(at: indexSet)
                }
            )
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(16)
        .padding()
    }
}

#Preview {
    GroceryListView()
}
