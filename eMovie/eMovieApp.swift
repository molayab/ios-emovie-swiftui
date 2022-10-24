//
//  eMovieApp.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import SwiftUI

@main
struct eMovieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
