//
//  IncomeExpenseData.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/2/25.
//

import Foundation

struct IncomeExpenseData: Identifiable{
    let id = UUID()
    let month: String
    let income: Double
    let expense: Double
}
