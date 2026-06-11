//
//  ContentView.swift
//  Day2
//
//  Created by Thaowpsta Saiid on 09/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State var useres: [User]
    @State var alert = false
    @State var deleteIndex: IndexSet?
    
    var body: some View {
        NavigationStack {
            List {

                ForEach(useres, id: \.id) { user in
                    NavigationLink {
                        UserDetails(user: user)
                    } label: {
                        UserRow(user: user)
                    }
                    .listRowBackground(Color.mint)
                }.onDelete(perform: {
                    indexSet in
                    deleteIndex = indexSet
                    alert = true
                    
                })
            }
            .listRowSpacing(16)
            .alert("Are you sure to delte this User", isPresented: $alert){
                
                Button("Delete", role: .destructive){
                    
                    if let indexSet = deleteIndex{
                        useres.remove(atOffsets: indexSet)
                    }
                }
                
                Button("Cancel", role: .cancel){
                    deleteIndex = nil
                }
            }
            .padding()

        }
    }
}

#Preview {
    ContentView(useres: users)
}
