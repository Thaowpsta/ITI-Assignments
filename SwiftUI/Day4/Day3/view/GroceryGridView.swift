//
//  GroceryListView.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftData
import SwiftUI


struct GroceryGridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    @State var alert = false
    @State var groceryToDelete: GroceryModel?
    
    @Environment(\.modelContext) private var modelContext
    @Query var groceries: [GroceryModel]
    @ObservedObject var viewModel: GroceryViewModel

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(groceries, id: \.id) {
                grocery in

                HStack {
                    Text(grocery.name)
                    Spacer()
                    Button {
                        groceryToDelete = grocery
                        alert = true

                    } label: {
                        Image(systemName: "trash.square.fill").resizable().frame(width: 32, height: 32).foregroundColor(.red).background(.white)
                    }
                }
                .listRowBackground(Color.mint)
            }.padding().background(Color.cyan).clipShape(RoundedRectangle(cornerRadius: 15))

        }
        .alert("Delete item", isPresented: $alert) {

            Button("Delete", role: .destructive) {

                if let item = groceryToDelete {
                    viewModel.removeGrocery(
                        item: item,
                        modelContext: modelContext
                    )
                }
            }

            Button("Cancel", role: .cancel) {
                groceryToDelete = nil
            }
        }message:{
            Text("Are you sure to delte this item?")
        }
        .padding()
        
    }
}

#Preview {
//    GroceryGridView(viewModel: viewModel)
}
