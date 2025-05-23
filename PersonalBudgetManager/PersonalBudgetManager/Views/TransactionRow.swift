//
//  TransactionRow.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

//Helper view for Dashboard
struct TransactionRow: View {
    let category: String
    let amount: String
    let type: TransactionType
    let categoryIcon: String?
    let categoryColor: String?
    
    @StateObject private var categoryVM = CategoryViewModel()
    
    enum TransactionType{
        case income, expense
    }
    
    var body: some View {
        HStack{
            // Category icon with color
            if let icon = categoryIcon, let colorHex = categoryColor {
                Image(systemName: icon)
                    .foregroundColor(categoryVM.colorFromHex(colorHex))
                    .font(.system(size: 20))
                    .frame(width: 30, height: 30)
                    .background(categoryVM.colorFromHex(colorHex).opacity(0.2))
                    .clipShape(Circle())
            } else {
                // Fallback to simple coloerd circle if no icon/color available
                Circle()
                    .fill(type == .income ? Color.green.opacity(0.5) : Color.red.opacity(0.5))
                    .frame(width: 30, height: 30)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(category)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(type == .income ? "Income" : "Expense")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Text(amount)
                    .font(.headline)
                    .foregroundColor(type == .income ? .green : .red)
                Image(systemName: type == .income ? "arrow.up" : "arrow.down")
                    .foregroundColor(type == .income ? .green : .red)
                    .font(.system(size: 12))
            }
        }
        .padding(.vertical, 8)
    }
}



//#Preview {
  //  TransactionRow(category: "test", amount: "test", type: .income)
//}
