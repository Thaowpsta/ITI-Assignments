//
//  UserRow.swift
//  Day2
//
//  Created by Thaowpsta Saiid on 09/06/2026.
//

import SwiftUI

struct UserRow: View {
    var user: User
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg"))
                .frame(width: 75, height: 75)
                .clipShape(Circle())
            
            Text(user.name).padding()
            Spacer()
            
            
        }.padding()
    }
}

#Preview {
    UserRow(user: users[0])
}
