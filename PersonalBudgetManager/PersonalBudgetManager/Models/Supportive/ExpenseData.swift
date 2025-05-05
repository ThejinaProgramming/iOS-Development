//
//  ExpenseData.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/2/25.
//

import Foundation

struct ExpenseData: Identifiable{
    let id = UUID()
    let category: String
    let pecentage: Double
    let amount: Double
}
