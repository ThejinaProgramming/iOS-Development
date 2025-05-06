//
//  EditTransactionView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import SwiftUI

struct EditTransactionView: View {
    @State private var isExpense: Bool = true
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isCategoryDropdownVisible: Bool = false
    @State private var availableCategories: [String] = ["Food", "Transport", "Entertainment", "Salary", "Other"]
    
    @ObservedObject var transaction: Transaction
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(String(transaction.amount))
    }
}


