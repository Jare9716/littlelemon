//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 7/04/25.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "empty"
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? "empty"
    let email = UserDefaults.standard.string(forKey: kEmail) ?? "empty"

    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 200, height: 200)
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
