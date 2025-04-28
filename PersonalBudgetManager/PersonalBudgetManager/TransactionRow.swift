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
    
    enum TransactionType{
        case income, expense
    }
    
    var body: some View {
        HStack{
            Circle()
                .fill(type == .income ? Color.green.opacity(0.5): Color.red.opacity(0.5))
                .frame(width: 8, height: 8)
            Text(category)
            Spacer()
            Text(amount)
            Image(systemName: type == .income ? "arrow.up" : "arrow.down")
                .foregroundColor(type == .income ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TransactionRow(category: "test", amount: "test", type: .income)
}
