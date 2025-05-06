//
//  Dashboard.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct Dashboard: View {
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
                                Text("$ 1300")
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
                                    Text("$ 1200")
                                }
                            }
                            Spacer()
                            
                            HStack{
                                Image(systemName: "arrow.down.left")
                                VStack{
                                    Text("Expense")
                                        .font(.subheadline)
                                    Text("$ 1000")
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
                            Text("Spent: $1200")
                            Spacer()
                            Text("Goal: $1000")
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top)
                
                //Add transaction button
                NavigationLink(destination: AddTransactionView()){
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding()
                
                
                //Recent Transactions
                GroupBox{
                    VStack(alignment: .leading){
                        Text("Recent Transactions")
                            .font(.headline)
                        ScrollView{
                            VStack{
                                TransactionRow(category: "Groceries", amount: "$ 20", type: .expense)
                                TransactionRow(category: "Salary", amount: "$ 2000", type: .income)
                                TransactionRow(category: "Transport", amount: "$ 20", type: .expense)
                                TransactionRow(category: "Groceries", amount: "$ 20", type: .expense)
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
    }
}

#Preview {
    Dashboard()
}
