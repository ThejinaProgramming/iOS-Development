//
//  SettingsManager.swift
//  PersonalBudgetManager
//
//  Created by user271720 on 5/6/25.
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled: Bool = false
    @AppStorage("selectedCurrencyCode") var selectedCurrencyCode: String = "USD"
    
    @Published var currencies: [Currency] = []
    @Published var selectedCurrency: Currency?
    
    private init() {
        loadCurrencies()
        updateSelectedCurrency()
    }
    
    func loadCurrencies() {
        guard let url = Bundle.main.url(forResource: "currencies", withExtension: "json") else {
            print("Could not find currencies.json file")
            // default currencies if file not found
            currencies = [
                Currency(code: "USD", symbol: "$", name: "US Dollar"),
                Currency(code: "EUR", symbol: "€", name: "Euro"),
                Currency(code: "GBP", symbol: "£", name: "British Pound")
            ]
            updateSelectedCurrency()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            currencies = try JSONDecoder().decode([Currency].self, from: data)
            updateSelectedCurrency()
        } catch {
            print("Error loading currencies: \(error.localizedDescription)")
            // Provide default currencies if loading fails
            currencies = [
                Currency(code: "USD", symbol: "$", name: "US Dollar"),
                Currency(code: "EUR", symbol: "€", name: "Euro"),
                Currency(code: "GBP", symbol: "£", name: "British Pound")
            ]
            updateSelectedCurrency()
        }
    }
    
    
    func updateSelectedCurrency() {
            selectedCurrency = currencies.first(where: { $0.code == selectedCurrencyCode }) ?? currencies.first
        }
        
        func setSelectedCurrency(_ currency: Currency) {
            selectedCurrencyCode = currency.code
            selectedCurrency = currency
        }
        
        func getCurrencySymbol() -> String {
            return selectedCurrency?.symbol ?? "$"
        }
}
