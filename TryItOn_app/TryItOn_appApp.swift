//
//  Furniture_appApp.swift
//  Furniture_app
//
//  Created by Abu Anwar MD Abdullah on 14/2/21.
//

import SwiftUI

@main
struct TryItOn_appApp: App {
    
    @StateObject private var persistenController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
        ContentView()
            .environment(\.managedObjectContext, persistenController.container.viewContext)
        }
    }
}
