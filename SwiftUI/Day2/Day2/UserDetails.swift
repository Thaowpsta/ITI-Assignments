//
//  UserDetails.swift
//  Day2
//
//  Created by Thaowpsta Saiid on 09/06/2026.
//

import SwiftUI

struct UserDetails: View {
    var user: User
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg"))
                .clipShape(Circle())
            
            Text("Name: \(user.name)").font(.title).bold().padding(.bottom, 30)
            Text("Email: \(user.email)").padding(.bottom, 10)
            Text("Phone Number: \(user.phone)").padding(.bottom, 10)
            Text("Website: \(user.website)").padding(.bottom, 10)
            Spacer()
        }.padding()
    }
}

#Preview {
    UserDetails(user: users[0])
}
