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
    
    @State private var searchText = ""
    //@State var selectedRecord = Transaction()
    //@State var id: String?
    //@State private var isSelected = false
    
    var body: some View {
        VStack (spacing: 0) {
            // Search Bar - Search transactions by Category
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search Transactions by Category", text: $searchText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()
            
            if filteredTransactions.isEmpty {
                ContentUnavailableView ("No Transactions Found", systemImage: "magnifyyingglass", description: Text("Try searching for a different category"))
                    .padding(.top, 50)
            } else {
                
                ScrollView {
                        GroupBox {
                            VStack {
                                ForEach(filteredTransactions) { transaction in
                                    NavigationLink(destination: AddTransactionView(transactionVM: transactionVM, mode: .edit(transaction), navigationSource: .transactionHistory)) {
                                        let category = findCategory(name: transaction.category ?? "", isExpense: transaction.isExpense)
                                                
                                        TransactionRow(
                                            category: transaction.category ?? "" ,
                                            amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount),
                                            type: transaction.isExpense ? .expense : .income,
                                            categoryIcon: category?.icon,
                                            categoryColor: category?.colorHex,
                                            date: transaction.date
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                            
                                    if transaction.id != transactionVM.transactions.last?.id {
                                        Divider()
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Transaction History")
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
    
    // Filter transactions based on search text
    private var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            return transactionVM.transactions
        } else {
            return transactionVM.transactions.filter { transaction in
                guard let category = transaction.category
                else {
                    return false
                }
                return category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}




