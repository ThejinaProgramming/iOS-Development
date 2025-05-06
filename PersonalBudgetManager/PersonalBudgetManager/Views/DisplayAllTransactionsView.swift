//
//  DisplayAllTransactionsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import SwiftUI

struct DisplayAllTransactionsView: View {
    @EnvironmentObject private var settingsManager: SettingsManager
    @ObservedObject var transactionVM: TransactionViewModel
    
    var body: some View {
        ScrollView{
            GroupBox{
                VStack{
                    ForEach(transactionVM.transactions){transaction in
                        Button{
                            
                        }
                        label:{
                            TransactionRow(category: transaction.category ?? "" , amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount), type: transaction.isExpense ? .expense : .income)
                        }
                    }
                }
                .navigationTitle("All Transactions")
                .padding()
            }
            .padding()
        }
    }
}

