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

                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty
                    {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)

                        isLoggedIn = true

                    } else {
                        showingAlert = true
                    }
                }.alert(
                    "Please fill all the fields",
                    isPresented: $showingAlert
                ) {}
            }  //Navigation part! The NavigationLink isActive was deprecated
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }

    }
}

#Preview {
    Onboarding()
}
