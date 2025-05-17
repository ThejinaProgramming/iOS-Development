//
//  AddTransactionView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var isExpense: Bool = true
    @State private var amount: String = ""
    @State private var selectedCategory: Category?
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isCategoryDropdownVisible: Bool = false
    @State private var showingCreateCategoryView = false
    
    @StateObject private var categoryVM = CategoryViewModel()
    @ObservedObject var transactionVM: TransactionViewModel
    @Binding var showingAddTransactionView: Bool
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Add Transaction")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                //Expense, income toggle
                HStack{
                    Button(action: {
                        isExpense = true
                        selectedCategory = nil
                    }) {
                        HStack{
                            Image(systemName: isExpense ? "circle.fill" : "circle")
                            Text("Expense")
                        }
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    
                    Button(action: {
                        isExpense = false
                        selectedCategory = nil
                    }) {
                        HStack{
                            Image(systemName: !isExpense ? "circle.fill" : "circle")
                            Text("Income")
                        }
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom)
                
                Text("Amount")
                    .font(.headline)
                TextField("Enter Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                
                Text("Category")
                    .font(.headline)
                Button(action: {
                    isCategoryDropdownVisible.toggle()
                }){
                    HStack{
                        if let category = selectedCategory {
                            Image(systemName: category.icon ?? "")
                                .foregroundColor(categoryVM.colorFromHex(category.colorHex ?? "#000000"))
                                .font(.system(size: 18))
                            Text(category.name ?? "")
                                .foregroundStyle(Color.primary)
                        } else {
                            Text("Select category")
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .overlay(alignment: .top){
                    if isCategoryDropdownVisible{
                        VStack(spacing: 0){
                            //Display categories based on transaction type
                            ForEach(categoryVM.getCategories(isExpense: isExpense)){ category in
                                Button(action: {
                                    selectedCategory = category
                                    isCategoryDropdownVisible = false
                                }){
                                    HStack {
                                        Image(systemName: category.icon ?? "")
                                            .foregroundColor(categoryVM.colorFromHex(category.colorHex ?? "#000000"))
                                            .font(.system(size: 18))
                                        Text(category.name ?? "")
                                            .foregroundStyle(Color.primary)
                                        Spacer()
                                        if selectedCategory?.id == category.id {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(Color.blue)
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal)
                                    .background(selectedCategory?.id == category.id ? Color.blue.opacity(0.1): Color.clear)
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Divider()
                                    .padding(.leading, 40)
                            }
                            
                            
                            //Add "+ Create New Category" option
                            Button(action: {
                                isCategoryDropdownVisible = false
                                showingCreateCategoryView = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundStyle(Color.blue)
                                        .font(.system(size: 18))
                                    Text("Create New Category")
                                        .foregroundStyle(Color.blue)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .offset(y: 50)
                        .zIndex(1)
                    }
                }
                .padding(.bottom, 10)
                
                Text("Date")
                    .font(.headline)
                DatePicker(
                    "Select Date", selection: $date, displayedComponents: [.date]
                )
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom, 10)
                
                Text("Description (Optional)")
                    .font(.headline)
                TextEditor(text: $description)
                    .frame(height: 100)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                Spacer()
                
                HStack{
                    Button("Save"){
                        if let category = selectedCategory {
                            transactionVM.addTransaction(amount: amount, category: category.name ?? "", date: date, isExpense: isExpense, note: description)
                            transactionVM.fetchTransactions()
                            showingAddTransactionView.toggle()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedCategory == nil ? Color.gray : Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(selectedCategory == nil)
                    
                    Button("Cancel"){
                        showingAddTransactionView.toggle()
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
        .onTapGesture {
            if isCategoryDropdownVisible {
                isCategoryDropdownVisible = false
            }
        }
        .sheet(isPresented: $showingCreateCategoryView) {
            CreateCategoryView(isExpense: isExpense, categoryVM: categoryVM, onDismiss: {
                categoryVM.fetchCategories()
            })
        }
        .onAppear {
            categoryVM.fetchCategories()
        }
    }
}

