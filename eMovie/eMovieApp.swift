//
//  eMovieApp.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import SwiftUI

protocol DomainAllowed { }

@main
struct eMovieApp: App {
    let persistenceController = PersistenceController.shared
    // This should be deliver on a secure way, but for time propuses we will use on a develop way.

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(viewModel: HomeViewModel())
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        
    }
}
