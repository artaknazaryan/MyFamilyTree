//
//  My_Family_TreeApp.swift
//  My Family Tree
//
//  Created by Artak on 13.09.24.
//

import SwiftUI
import SwiftData

@main
struct My_Family_TreeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TreeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
