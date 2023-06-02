//
//  PocBLEApp.swift
//  PocBLE
//
//  Created by Maykon Meneghel on 01/06/23.
//

import SwiftUI

@main
struct PocBLEApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
