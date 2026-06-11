//
//  CircularImg.swift
//  Day1
//
//  Created by Thaowpsta Saiid on 08/06/2026.
//

import SwiftUI

struct CircularImg: View {
    var body: some View {
        Image(.qaitbay).resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(radius: 7)
            .overlay(Circle().stroke(Color.black, lineWidth: 1))
    }
}

#Preview {
    CircularImg()
}
