//
//  ContentView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var reminderVM : ReminderViewModel
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var assetVM = AssetsViewModel()
    
    var body: some View {
        TabView{
            Dashboard().tabItem {
                Label("Home", systemImage: "house")
            }
            SetBudgetView(assetVM: assetVM).tabItem {
                Label("Budget", systemImage: "dollarsign")
            }
            CreateCategoryView().tabItem {
                Label("Category", systemImage: "table")
            }
            RemindersView(reminderViewModel: reminderVM).tabItem {
                Label("Reminder", systemImage: "clock")
            }
            AnalyticsView().tabItem {
                Label("Analytics", systemImage: "brain")
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

