//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by admin on 03/02/25.
//

import SwiftUI

@main
struct TaskManagementApp: App {
    let persist = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persist.container.viewContext)
            
        }
    }
}
