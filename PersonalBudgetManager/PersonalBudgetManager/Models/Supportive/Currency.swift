//
//  Currency.swift
//  PersonalBudgetManager
//
//  Created by user271720 on 5/6/25.
//

import Foundation

struct Currency: Identifiable, Codable, Equatable {
    
    var id: String { code }
    let code: String
    let symbol: String
    let name: String
    
    var displayName: String {
        return "\(symbol) \(code)"
    }
    
    /*init(code: String, name: String, symbol: String) {
        self.id = code
        self.code = code
        self.name = name
        self.symbol = symbol
    }*/
    
    // Default USD currency in case loading fails
    static let defaultCurrency = Currency(code: "USD", symbol: "$", name: "US dollar")
}

// Service to load and manage currencies
class CurrencyService {
    static let shared = CurrencyService()
    
    private init() {}
    
    // Load currencies from JSON file
    func loadCurrencies() -> [Currency] {
            guard let url = Bundle.main.url(forResource: "currencies", withExtension: "json") else {
                print("Could not find currencies.json")
                return [Currency.defaultCurrency]
            }
            
            do {
                let data = try Data(contentsOf: url)
                let currencies = try JSONDecoder().decode([Currency].self, from: data)
                return currencies
            } catch {
                print("Error loading currencies: \(error)")
                return [Currency.defaultCurrency]
            }
        }
    
    // Get currency by code
    func getCurrency(byCode code: String, from currencies: [Currency]) -> Currency {
            return currencies.first(where: { $0.code == code }) ?? Currency.defaultCurrency
        }
    
}
