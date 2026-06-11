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
            GroceryGridView(viewModel: viewModel)
            Spacer()
        }

        .padding()
    }
}

#Preview {
    ContentView()
}
