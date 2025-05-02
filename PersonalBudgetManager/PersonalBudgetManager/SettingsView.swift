//
//  SettingsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.title2)
                .padding(.bottom)
                .bold()
            
            // Currency
            GroupBox {
                HStack {
                    Image(systemName: "dollarsign.circle") // Example icon
                    VStack(alignment: .leading) {
                        Text("Currency")
                            .font(.headline)
                        Text("Select Your preferd currency")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // Currency Picker (Placeholder)
                    Picker("USD", selection: .constant(0)) { // Replace with actual picker logic
                        Text("USD").tag(0)
                        Text("EUR").tag(1)
                        // Add more currencies
                    }
                    .frame(width: 80)
                }
            }
            .padding(.bottom)
            
            // Dark Mode
            GroupBox {
                HStack {
                    Image(systemName: "moon.circle") // Example icon
                    VStack(alignment: .leading){
                        Text("Dark Mode")
                            .font(.headline)
                        Text("Enable dark theme")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Toggle("", isOn: $isDarkModeEnabled)
                }
            }
            .padding(.bottom)
            
            // Set Reminders
            GroupBox {
                HStack {
                    Image(systemName: "bell.circle") // Example icon
                    VStack(alignment: .leading){
                        Text("Set Reminders")
                            .font(.headline)
                        Text("Set your custom reminders")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        // Action: Navigate to reminders screen
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.bottom)
            
            Spacer()
            
            // LogOut Button
            Button(action: {
                // Action: Log out the user
            }) {
                HStack {
                    Image(systemName: "arrow.right.left")
                    Text("LogOut")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
