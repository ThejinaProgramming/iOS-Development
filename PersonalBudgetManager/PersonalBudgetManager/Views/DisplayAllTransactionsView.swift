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
    
    @State var selectedRecord = Transaction()
    @State var id: String?
    @State private var isSelected = false
    
    var body: some View {
        ScrollView{
            GroupBox{
                VStack{
                    ForEach($transactionVM.transactions){$transaction in
                        Button(action: {
                            isSelected.toggle()
                        }){
                            TransactionRow(category: transaction.category ?? "" , amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount), type: transaction.isExpense ? .expense : .income)
                        }
                        .onTapGesture {
                            selectedRecord = transaction
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

