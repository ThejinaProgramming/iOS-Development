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
    @StateObject private var categoryVM = CategoryViewModel()
    
    @State var selectedRecord = Transaction()
    @State var id: String?
    @State private var isSelected = false
    
    var body: some View {
        ScrollView{
            GroupBox{
                VStack{
                    ForEach(transactionVM.transactions){ transaction in
                        NavigationLink(destination: AddTransactionView(transactionVM: transactionVM, mode: .edit(transaction), navigationSource: .transactionHistory)) {
                            let category = findCategory(name: transaction.category ?? "", isExpense: transaction.isExpense)
                            
                            TransactionRow(
                                category: transaction.category ?? "" ,
                                amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount),
                                type: transaction.isExpense ? .expense : .income,
                                categoryIcon: category?.icon,
                                categoryColor: category?.colorHex
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if transaction.id != transactionVM.transactions.last?.id {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle("All Transactions")
                .padding()
                
            }
            .padding()
        }
        .onAppear {
            categoryVM.fetchCategories()
            transactionVM.fetchTransactions()
        }
    }
    
    //Helper function to find category by name
    private func findCategory(name: String, isExpense: Bool) -> Category? {
        return categoryVM.categories.first { category in
            category.name == name && category.isExpense == isExpense
        }
    }
}

