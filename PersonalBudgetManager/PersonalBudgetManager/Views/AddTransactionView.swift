//
//  AddTransactionView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

enum TransactionMode {
    case create
    case edit(Transaction)
}

enum NavigationSource {
    case dashboard
    case transactionHistory
}

struct AddTransactionView: View {
    @State private var isExpense: Bool = true
    @State private var amount: String = ""
    @State private var selectedCategory: Category?
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isCategoryDropdownVisible: Bool = false
    @State private var showingCreateCategoryView = false
    @State private var categoryButtonFrame: CGRect = .zero
    @State private var showingDeleteConfirmation = false
    
    @StateObject private var categoryVM = CategoryViewModel()
    @ObservedObject var transactionVM: TransactionViewModel
    @Environment(\.dismiss) private var dismiss
    
    let mode: TransactionMode
    let navigationSource: NavigationSource
    
    private var isEditMode: Bool {
        if case .edit = mode {
            return true
        }
        return false
    }
    
    private var editingTransaction: Transaction? {
        if case .edit(let transaction) = mode {
            return transaction
        }
        return nil
    }
    
    private var navigationtitle: String {
        isEditMode ? "Edit Transaction" : "Add Transaction"
    }
    
    init(transactionVM: TransactionViewModel, mode: TransactionMode = .create, navigationSource: NavigationSource = .dashboard) {
        self.transactionVM = transactionVM
        self.mode = mode
        self.navigationSource = navigationSource
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(navigationtitle)
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
                            .foregroundColor(.primary)
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
                            .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom)
                    
                    //Add Amount
                    Text("Amount")
                        .font(.headline)
                    TextField("Enter Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.bottom, 10)
                    
                    //Category Selection
                    Text("Category")
                        .font(.headline)
                    Button {
                        isCategoryDropdownVisible.toggle()
                    } label: {
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
                    .padding(.bottom, 10)
                    .background(
                        GeometryReader { geo -> Color in
                            DispatchQueue.main.async {
                                self.categoryButtonFrame = geo.frame(in: .global)
                            }
                            return Color.clear
                        }
                    )
                    
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
                    
                    // Action Buttons
                    VStack(spacing: 10) {
                        if isEditMode {
                            // Delete button for edit mode
                            Button("Delete Transaction") {
                                showingDeleteConfirmation = true
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        
                        HStack {
                            Button(isEditMode ? "Save Changes" : "Save") {
                                if isEditMode {
                                    updateTransaction()
                                } else {
                                    createTransaction()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedCategory == nil ? Color.blue : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .disabled(selectedCategory == nil)
                            
                            Button("Cancel") {
                                dismiss()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            .onTapGesture {
                if isCategoryDropdownVisible {
                    isCategoryDropdownVisible = false
                }
            }
            
            // Category Selection DropDown
                if isCategoryDropdownVisible{
                        VStack(spacing: 0){
                            //Scrollable categories list
                            ScrollView {
                                VStack(spacing: 0) {
                                    //Display categories based on transaction type
                                    ForEach(categoryVM.getCategories(isExpense: isExpense)){ category in
                                        Button {
                                            selectedCategory = category
                                            isCategoryDropdownVisible = false
                                        } label: {
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
                                        .buttonStyle(.plain)
                                        
                                        if category.id != categoryVM.getCategories(isExpense: isExpense).last?.id {
                                            Divider()
                                                .padding(.leading, 40)
                                        }
                                    }
                                }
                            }
                            .frame(maxHeight: 250)
                            
                            Divider()
                            
                            //Add "+ Create New Category" option
                            Button {
                                isCategoryDropdownVisible = false
                                showingCreateCategoryView = true
                            } label: {
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
                        .frame(width: categoryButtonFrame.width)
                        .position(x: categoryButtonFrame.midX, y: categoryButtonFrame.maxY + 150)
                        .zIndex(100)
                    }
                    
            
            // Invisible overlay to capture taps when dropdown is visible
            if isCategoryDropdownVisible {
                Color.black.opacity(0.001)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        isCategoryDropdownVisible = false
                    }
                    .zIndex(90)
            }
            
        }
        .sheet(isPresented: $showingCreateCategoryView) {
            CreateCategoryView(isExpense: isExpense, categoryVM: categoryVM, onDismiss: {
                categoryVM.fetchCategories()
            })
        }
        
        .confirmationDialog("Delete Transaction", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                deleteTransaction()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this transaction? This action cannot be undone.")
        }
        
        .onAppear {
            categoryVM.fetchCategories()
            loadTransactionData()
        }
        .navigationTitle(navigationtitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadTransactionData() {
        if let transaction = editingTransaction {
            amount = String(transaction.amount)
            isExpense = transaction.isExpense
            date = transaction.date ?? Date()
            description = transaction.note ?? ""
            
            // Find and set the selected category
            selectedCategory = categoryVM.categories.first { category in
                category.name == transaction.category && category.isExpense == transaction.isExpense
            }
        }
    }
    
    private func createTransaction() {
        if let category = selectedCategory {
            transactionVM.addTransaction(amount: amount, category: category.name ?? "", date: date, isExpense: isExpense, note: description)
            transactionVM.fetchTransactions()
            dismiss()
        }
    }
    
    private func updateTransaction() {
        if let transaction = editingTransaction,
           let category = selectedCategory {
            transactionVM.updateTransaction(transaction, amount: amount, category: category.name ?? "", date: date, isExpense: isExpense, note: description)
            transactionVM.fetchTransactions()
            dismiss()
        }
    }
    
    private func deleteTransaction() {
        if let transaction = editingTransaction {
            transactionVM.deleteTransaction(transaction)
            transactionVM.fetchTransactions()
            dismiss()
        }
    }
}

