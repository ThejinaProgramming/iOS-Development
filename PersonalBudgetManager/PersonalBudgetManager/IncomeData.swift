//
//  IncomeData.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/2/25.
//

import Foundation

struct IncomeData: Identifiable{
    let id = UUID()
    let source: String
    let percentage: Double
    let amount: Double
}
