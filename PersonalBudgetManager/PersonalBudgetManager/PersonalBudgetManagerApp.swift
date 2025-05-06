//
//  PersonalBudgetManagerApp.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/22/25.
//

import SwiftUI

@main
struct PersonalBudgetManagerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var reminderVM = ReminderViewModel()
    @StateObject private var settingsManager = SettingsManager.shared
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    var body: some Scene {
        WindowGroup {
            InitialView(reminderVM: reminderVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settingsManager)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}
