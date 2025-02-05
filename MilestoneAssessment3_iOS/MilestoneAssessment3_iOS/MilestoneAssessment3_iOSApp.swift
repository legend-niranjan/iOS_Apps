//
//  MilestoneAssessment3_iOSApp.swift
//  MilestoneAssessment3_iOS
//
//  Created by admin on 04/02/25.
//

import SwiftUI

@main
struct MilestoneAssessment3_iOSApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
