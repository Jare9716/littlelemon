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
        VStack() {
            HStack{
                Text("Personal information")
                    .font(.largeTitle)
                Spacer()
            }
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 200, height: 200)
            VStack(spacing: 10){
                Text("\(firstName) \(lastName)")
                    .font(.title)
                Text(email)
            }
            Spacer()
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("Logout")
                        .font(.body)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(3)
                .foregroundStyle(
                    Color(.black)
                )
                .fontWeight(.semibold)

            }
            .buttonStyle(.borderedProminent)
            .tint(
                Color(
                    red: 244 / 255,
                    green: 206 / 255,
                    blue: 20 / 255
                )
            )
        }
        .frame( minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    UserProfile()
}
