//
//  Currency.swift
//  PersonalBudgetManager
//
//  Created by user271720 on 5/6/25.
//

import Foundation

struct Currency: Identifiable, Codable, Hashable {
    
    let id = String
    let code = String
    let name = String
    let symbol = String
    
    init(code: String, name: String, symbol: String) {
        self.id = code
        self.code = code
        self.name = name
        self.symbol = symbol
    }
    
}
