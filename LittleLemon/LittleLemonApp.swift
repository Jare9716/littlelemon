//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Julian Andres  Rodriguez Escboar on 31/03/25.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()

        }
    }
}
