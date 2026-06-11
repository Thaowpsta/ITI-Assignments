//
//  ContentView.swift
//  Day1
//
//  Created by Thaowpsta Saiid on 08/06/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var changedTxt = ""
    @State private var tembTxt = ""
    
    var body: some View {
        VStack {
            MapView().frame(height: 100)
            CircularImg().offset(y: -100).padding(.bottom, -100)
            
            Text(changedTxt).font(.system(.largeTitle).bold()).foregroundColor(.red)
        
            HStack{
                Text("Park state")
                Spacer()
                Text("Park City")
            }.padding()
            
            Divider()
            
            TextField("Enter the Place name", text: $tembTxt).padding()
            
            
            Button("Enter to change label"){
                changedTxt = tembTxt
            }
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
