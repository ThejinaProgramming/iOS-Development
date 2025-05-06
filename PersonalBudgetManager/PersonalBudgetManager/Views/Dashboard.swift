//
//  Dashboard.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject private var settingsManager: SettingsManager
    @State private var showingAddTransactionView = false
    
    @StateObject private var transactionVM = TransactionViewModel()
    
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
                                Text("\(settingsManager.getCurrencySymbol()) 1300")
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
                                    Text("\(settingsManager.getCurrencySymbol()) 1200")
                                }
                            }
                            Spacer()
                            
                            HStack{
                                Image(systemName: "arrow.down.left")
                                VStack{
                                    Text("Expense")
                                        .font(.subheadline)
                                    Text("\(settingsManager.getCurrencySymbol()) 1000")
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
                            Text("60%")
                                .font(.title)
                            Spacer()
                        }
                        ProgressBar(value: 0.6)
                        HStack{
                            Text("Spent: \(settingsManager.getCurrencySymbol())1200")
                            Spacer()
                            Text("Goal: \(settingsManager.getCurrencySymbol())1000")
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top)
                
                //Add transaction button
                Button{
                    showingAddTransactionView = true
                }label: {
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
                                ForEach(transactionVM.transactions){transaction in
                                    Button{
                                        
                                    }
                                    label:{
                                        TransactionRow(category: transaction.category ?? "" , amount: "\(settingsManager.getCurrencySymbol())" + String(transaction.amount), type: transaction.isExpense ? .expense : .income)
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
                GroupBox{
                    Button("View All Transactions"){
                        
                    }
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .sheet(isPresented: $showingAddTransactionView){
            AddTransactionView(transactionVM: transactionVM, showingAddTransactionView: $showingAddTransactionView)
        }
        .onAppear{
            transactionVM.fetchTransactions()
        }
    }
}

#Preview {
    Dashboard()
        .environmentObject(SettingsManager.shared)
}
