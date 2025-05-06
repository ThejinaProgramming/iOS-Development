//
//  SetBudgetView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct SetBudgetView: View {
    @State private var budgetAmount: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var showingDatePickerStart = false
    @State private var showingDatePickerEnd = false
    @State private var isMonthlyBudget: Bool = true
    @EnvironmentObject private var settingsManager: SettingsManager
    
    // Asset
    @ObservedObject var assetVM : AssetsViewModel
    
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
                    Text("Assets")
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
                    Text("Amount")
                        .font(.headline)
                    TextField("Enter Amount", text: $budgetAmount)
                        .keyboardType(.numberPad)
                        .padding()
                        .border(Color.gray, width: 1)
                }
                
                Spacer()
                
                HStack{
                    List{
                        ForEach(assetVM.assets){asset in
                            Button{
                                
                            }
                            label:{
                                Text(String(asset.amount))
                            }
                        }
                    }
                }
                
                HStack{
                    Button("Save"){
                        assetVM.addAsset(amount: Double(budgetAmount) ?? 0.0)
                        budgetAmount = ""
                        assetVM.fetchAssets()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel"){
                        budgetAmount = ""
                        assetVM.fetchAssets()
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

