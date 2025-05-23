//
//  Dashboard.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject private var settingsManager: SettingsManager
    
    @StateObject private var transactionVM = TransactionViewModel()
    @StateObject private var assetsVM = AssetsViewModel()
    @StateObject private var categoryVM = CategoryViewModel()
    
    // Helper function to find category by name
    private func findCategory(name: String, isExpense: Bool) -> Category? {
        return categoryVM.categories.first { category in
            category.name == name && category.isExpense == isExpense
        }
    }
    
    
    var body: some View {
        NavigationStack{
            VStack{
                //Top summary view
                GroupBox{
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "creditcard")
                            VStack{
                                Text("Total Balance")
                                    .font(.headline)
                                Text("\(settingsManager.getCurrencySymbol())" + String(assetsVM.calculateTotalAssets() + transactionVM.calculateTotalIncome() - transactionVM.calculateTotalExpense()))
                                    .font(.title)
                            }
                        }
                        .padding(.vertical)
                        
                        HStack{
                            HStack{
                                Image(systemName: "arrow.up.right")
                                VStack{
                                    Text("Income")
                                        .font(.subheadline)
                                    Text("\(settingsManager.getCurrencySymbol())" + String(transactionVM.calculateTotalIncome()))
                                }
                            }
                            Spacer()
                            
                            HStack{
                                Image(systemName: "arrow.down.left")
                                VStack{
                                    Text("Expense")
                                        .font(.subheadline)
                                    Text("\(settingsManager.getCurrencySymbol())" + String(transactionVM.calculateTotalExpense()))
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                //Budget progress
                GroupBox{
                    VStack(alignment: .leading){
                        Text("Budget Progress")
                            .font(.headline)
                        HStack{
                            Text(String((transactionVM.calculateTotalExpense()/(assetsVM.calculateTotalAssets() + transactionVM.calculateTotalIncome())*100).rounded()))
                                .font(.title)
                            Spacer()
                        }
                        ProgressBar(value: (transactionVM.calculateTotalExpense()/(assetsVM.calculateTotalAssets() + transactionVM.calculateTotalIncome())))
                        HStack{
                            Text("Spent: \(settingsManager.getCurrencySymbol())" + String(transactionVM.calculateTotalExpense()))
                            Spacer()
                            Text("Total: \(settingsManager.getCurrencySymbol())" + String((assetsVM.calculateTotalAssets() + transactionVM.calculateTotalIncome())))
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top)
                
                //Add transaction button
                NavigationLink(destination: AddTransactionView(transactionVM: transactionVM)) {
                        Image(systemName: "plus")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                
                //Recent Transactions
                GroupBox{
                    VStack(alignment: .leading){
                        Text("Recent Transactions")
                            .font(.headline)
                        ScrollView{
                            VStack{
                                ForEach(transactionVM.transactions.prefix(5)){transaction in
                                    Button{
                                        
                                    }
                                    label:{
                                        let category = findCategory(name: transaction.category ?? "", isExpense: transaction.isExpense)
                                        
                                        TransactionRow(
                                            category: transaction.category ?? "" ,
                                            amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount),
                                            type: transaction.isExpense ? .expense : .income,
                                            categoryIcon: category?.icon,
                                            categoryColor: category?.colorHex
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
                
                //View Transaction button
                NavigationStack{
                    GroupBox{
                        NavigationLink(destination: DisplayAllTransactionsView(transactionVM: transactionVM)){
                            Text("View All Transaction")
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
        }
        
        .onAppear{
            transactionVM.fetchTransactions()
            categoryVM.fetchCategories()
        }
    }
}

#Preview {
    Dashboard()
        .environmentObject(SettingsManager.shared)
}
