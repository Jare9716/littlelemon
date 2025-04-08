//
//  Home.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 7/04/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Perfil", systemImage: "square.and.pencil")
                }

        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
