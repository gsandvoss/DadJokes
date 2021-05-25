//
//  DadJokesApp.swift
//  DadJokes
//
//  Created by glenn sandvoss on 5/25/21.
//

import SwiftUI

@main
struct DadJokesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
