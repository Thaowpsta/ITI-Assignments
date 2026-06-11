//
//  ContentView.swift
//  Day3
//
//  Created by Thaowpsta Saiid on 10/06/2026.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = GroceryViewModel()
    var body: some View {
        VStack {
            AddGroceryHeaderView(viewModel: viewModel)
            GroceryListView(viewModel: viewModel)
        }

        .padding()
    }
}

#Preview {
    ContentView()
}
