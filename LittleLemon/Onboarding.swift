//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 5/04/25.
//

import SwiftUI

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "is_logged_in_key"

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                VStack(alignment: .leading) {
                    Text("Little lemon")
                        .font(.system(size: 56))
                        .fontDesign(.serif)
                        .foregroundStyle(
                            Color(
                                red: 244 / 255,
                                green: 206 / 255,
                                blue: 20 / 255
                            )
                        )
                    Text("Chicago")
                        .font(.title)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                    HStack {
                        Text(
                            "We are a family owned Mediterranean restaurant, focused on traditional recepies served with a modern twist."
                        )
                        .font(.body)
                        .fontDesign(.serif)
                        .foregroundStyle(.white)
                        Image("Hero-image")
                            .resizable()
                            .frame(width: 100, height: 150)
                            .cornerRadius(16)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
                )
                VStack(spacing: 20) {
                    TextField("First Name", text: $firstName)

                    TextField("Last Name", text: $lastName)

                    TextField("Email", text: $email)

                    Button(action: {
                        if !firstName.isEmpty && !lastName.isEmpty
                            && !email.isEmpty
                        {
                            UserDefaults.standard.set(
                                firstName,
                                forKey: kFirstName
                            )
                            UserDefaults.standard.set(
                                lastName,
                                forKey: kLastName
                            )
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)

                            isLoggedIn = true

                        } else {
                            showingAlert = true
                        }
                    }) {
                        HStack {
                            Text("Register")
                                .font(.body)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(3)
                        .foregroundStyle(
                            Color(.black)
                        )
                        .fontWeight(.semibold)

                    }
                    .alert(
                        "Please fill all the fields",
                        isPresented: $showingAlert
                    ) {}
                    .buttonStyle(.borderedProminent)
                    .tint(
                        Color(
                            red: 244 / 255,
                            green: 206 / 255,
                            blue: 20 / 255
                        )
                    )
                }
                .padding()
                .textFieldStyle(.roundedBorder)

            }
            //Navigation part! The NavigationLink isActive was deprecated
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            Spacer()
        }

    }
}

#Preview {
    Onboarding()
}
