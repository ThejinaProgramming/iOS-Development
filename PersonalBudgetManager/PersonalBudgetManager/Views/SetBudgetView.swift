//
//  SetBudgetView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct SetBudgetView: View {
    @State private var budgetAmount: String = ""
    @State private var budgetPeriod: BudgetPeriod = .monthly
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var showingDatePickerStart = false
    @State private var showingDatePickerEnd = false
    @State private var isMonthlyBudget: Bool = true
    @EnvironmentObject private var settingsManager: SettingsManager
    
    let totalBudget: Double = 2000
    let spendBudget: Double = 1200
    
    var remainingBudget: Double {
        totalBudget - spendBudget
    }
    
    var budgetUsedPecentage: Double {
        spendBudget/totalBudget
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .leading){
                    Text("Set Budget Goal")
                        .font(.title2)
                        .bold()
                }
                
                //Used budget section
                GroupBox{
                    VStack(alignment: .leading, spacing: 10){
                        HStack{
                            Text("Budget Used")
                            Spacer()
                            Text("\(Int(budgetUsedPecentage * 100))%")
                                .font(.headline)
                        }
                        ProgressBar(value: budgetUsedPecentage)
                            .tint(.blue)
                        HStack{
                            Text("Total Budget:")
                            Spacer()
                            Text("\(settingsManager.getCurrencySymbol())\(totalBudget, specifier: "%.0f")")
                        }
                        HStack{
                            Text("Spent:")
                            Spacer()
                            Text("\(settingsManager.getCurrencySymbol())\(spendBudget, specifier: "%.0f")")
                        }
                        HStack{
                            Text("Remaining:")
                            Spacer()
                            Text("\(settingsManager.getCurrencySymbol())\(remainingBudget, specifier: "%.0f")")
                                .foregroundColor(remainingBudget >= 0 ? .green: .red)
                        }
                    }
                }
                
                VStack(alignment: .leading){
                    Text("Budget Amount")
                        .font(.headline)
                    TextField("Enter Budget Amount", text: $budgetAmount)
                        .keyboardType(.numberPad)
                        .padding()
                        .border(Color.gray, width: 1)
                }
                
                
                //Budget period section
                Text("Budget Period")
                    .font(.headline)
                HStack{
                    HStack{
                        Button(action: {
                            budgetPeriod = .monthly
                            isMonthlyBudget = true
                        }){
                            HStack{
                                Image(systemName: isMonthlyBudget ? "circle.fill" : "circle")
                                Text("Monthly Budget")
                            }
                            .padding(.horizontal)
                            .foregroundColor(.black)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        
                        Button(action: {
                            budgetPeriod = .custom
                            isMonthlyBudget = false
                        }){
                            HStack{
                                Image(systemName: !isMonthlyBudget ? "circle.fill" : "circle")
                                Text("Custom Range")
                            }
                            .padding(.horizontal)
                            .foregroundColor(.black)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                if budgetPeriod == .custom{
                    HStack{
                        VStack{
                            Text("Start Date: ")
                            DatePicker(
                                "", selection : $startDate, displayedComponents: [.date]
                            )
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        
                        Text("to")
                        
                        VStack{
                            Text("End Date: ")
                            DatePicker(
                                "", selection: $endDate, displayedComponents: [.date]
                            )
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                }

                
                HStack{
                    Button("Delete"){
                        
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                }
                Spacer()
                
                HStack{
                    Button("Save"){
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel"){
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }




enum BudgetPeriod{
    case monthly
    case custom
}

#Preview {
    SetBudgetView()
        .environmentObject(SettingsManager.shared)
}
