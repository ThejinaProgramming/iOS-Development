//
//  TransactionViewModel.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import Foundation
import CoreData

class TransactionViewModel: ObservableObject{
    @Published var transactions: [Transaction] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.viewContext = viewContext
        fetchTransactions()
    }
    
    func fetchTransactions(){
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)]
        
        do{
            transactions = try viewContext.fetch(request)
        }catch{
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    // MARK: Create (Add) Transaction
    func addTransaction(amount: String, category: String, date: Date, isExpense: Bool, note: String){
        let transactionItem = Transaction(context: viewContext)
        transactionItem.id = UUID()
        transactionItem.amount = Double(amount) ?? 0.0
        transactionItem.category = category
        transactionItem.date = date
        transactionItem.isExpense = isExpense
        transactionItem.note = note
        
        saveTransaction()
        objectWillChange.send()
    }
    
    // MARK: Update (Edit) Transactions
    func updateTransaction(_ transaction: Transaction, amount: String, category: String, date: Date, isExpense: Bool, note: String) {
        transaction.amount = Double(amount) ?? 0.0
        transaction.category = category
        transaction.date = date
        transaction.isExpense = isExpense
        transaction.note = note
        
        saveTransaction()
        objectWillChange.send()
    }
    
    // MARK: Delete Transaction
    func deleteTransaction(_ transactionItem: Transaction){
        viewContext.delete(transactionItem)
        
        saveTransaction()
        objectWillChange.send()
    }
    
    private func saveTransaction(){
        PersistenceController.shared.saveContext()
    }
    
    
    // functions for analytics
    func calculateTotalExpense() -> Double{
        return transactions.filter{$0.isExpense == true}.reduce(0){$0 + $1.amount}
    }
    
    func calculateTotalIncome() -> Double{
        return transactions.filter{$0.isExpense == false}.reduce(0){$0 + $1.amount}
    }
}
