//
//  AnalyticsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI
import Charts

struct AnalyticsView: View {
    //sample data
    let expenses: [ExpenseData] = [
        ExpenseData(category: "Groceries", pecentage: 0.65, amount: 1300),
        ExpenseData(category: "Education", pecentage: 0.45, amount: 900),
        ExpenseData(category: "Health", pecentage: 0.15, amount: 300),
        ExpenseData(category: "Transport", pecentage: 0.02, amount: 150)
    ]
    
    let incomes: [IncomeData] = [
        IncomeData(source: "Salary", percentage: 0.7, amount: 3500),
        IncomeData(source: "Bonus", percentage: 0.15, amount: 750),
        IncomeData(source: "Gift", percentage: 0.1, amount: 500),
        IncomeData(source: "Other", percentage: 0.025, amount: 125)
    ]
    
    let incomeVsExpenses: [IncomeExpenseData] = [
        IncomeExpenseData(month: "Jan", income: 1500, expense: 1200),
        IncomeExpenseData(month: "Feb", income: 2000, expense: 1000),
        IncomeExpenseData(month: "Mar", income: 1800, expense: 800),
        IncomeExpenseData(month: "Apr", income: 2200, expense: 1500)
    ]
    
    let budgetData = BudgetData(totalBudget: 2000, spent: 1200)
    
    var remainingBudget: Double{
        budgetData.totalBudget - budgetData.spent
    }
    
    var budgetUsedPercentage: Double{
        budgetData.totalBudget > 0 ? budgetData.spent/budgetData.totalBudget: 0
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20){
                    Text("Analytics")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    
                    GroupBox(label: Text("Expense Breakdown").font(.caption)){
                        HStack{
                            Chart{
                                ForEach(expenses){ expense in
                                    SectorMark(angle: .value("Amount", expense.amount), angularInset: 0.5)
                                        .foregroundStyle(by: .value("Category", expense.category))
                                }
                            }
                        }
                    }
                    
                    GroupBox(label: Text("Income Breakdown").font(.caption)){
                        HStack{
                            Chart{
                                ForEach(incomes){ income in
                                    SectorMark(angle: .value("Amount", income.amount), angularInset: 0.5)
                                        .foregroundStyle(by: .value("Source", income.source))
                                }
                            }
                        }
                    }
                    
                    GroupBox(label: Text("Income Vs Expenses").font(.caption)){
                        Chart{
                            ForEach(incomeVsExpenses){item in
                                BarMark(
                                    x: .value("Month", item.month),
                                    y: .value("Income", item.income)
                                )
                                .foregroundStyle(.green)
                                .annotation(position: .top){
                                    Text("Income")
                                        .font(.caption2)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        
                        Chart{
                            ForEach(incomeVsExpenses){item in
                                BarMark(
                                    x: .value("Month", item.month),
                                    y: .value("Expense", item.expense)
                                )
                                .foregroundStyle(Color.red)
                                .annotation(position: .top){
                                    Text("Expense")
                                        .font(.caption2)
                                        .foregroundColor(Color.red)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    AnalyticsView()
}
