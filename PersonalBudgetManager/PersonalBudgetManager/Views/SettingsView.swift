//
//  SettingsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingsManager = SettingsManager.shared
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
       
    
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
                        Text("Select Your preferrd currency")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                
                    // Currency Picker dropdown menu
                    Menu {
                        ForEach(settingsManager.currencies) { currency in
                            Button(action: {
                                settingsManager.setSelectedCurrency(currency)
                            }) {
                                HStack {
                                    Text("\(currency.symbol) \(currency.code)")
                                    if currency.code == settingsManager.selectedCurrencyCode {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                        
                    } label: {
                        HStack {
                            Text(settingsManager.selectedCurrency?.code ?? "USD")
                            Image(systemName: "chevron.down")
                                .font(.caption)
                            }
                        .foregroundStyle(Color.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        }
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
                        .onChange(of: isDarkModeEnabled) { _, _ in
                        // handled by app's environment
                        }
                                        
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
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
    }
}

#Preview {
    SettingsView()
}
