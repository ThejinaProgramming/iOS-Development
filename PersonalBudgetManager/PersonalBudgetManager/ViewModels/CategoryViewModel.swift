//
//  CategoryViewModel.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/5/25.
//

import Foundation
import CoreData
import SwiftUI

class CategoryViewModel: ObservableObject{
    @Published var categories: [Category] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        fetchCategories()
        
        // Check if default categories need to be created
        if categories.isEmpty {
            createDefaultCategories()
        }
    }
    
    func fetchCategories() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.name, ascending: true)]
        
        do {
            categories = try viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    func getCategories(isExpense: Bool) -> [Category] {
        return categories.filter { $0.isExpense == isExpense }
    }
    
    func addCategory(name: String, icon: String, colorHex: String, isExpense: Bool) {
        let newCategory = Category(context: viewContext)
        newCategory.id = UUID()
        newCategory.name = name
        newCategory.icon = icon
        newCategory.colorHex = colorHex
        newCategory.isExpense = isExpense
        newCategory.isDefault = false
        
        saveCategory()
        fetchCategories()
    }
    
    func deleteCategory(_ category: Category){
        //only allow deletion of non-default categories
        if !category.isDefault {
            viewContext.delete(category)
            saveCategory()
            fetchCategories()
        }
    }
    
    private func saveCategory() {
        PersistenceController.shared.saveContext()
    }
    
    //Helper to convert UIColor to hex string
    func hexStringFromColor(_ color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }

    //Helper to convert hex string to Color
    func colorFromHex(_ hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16 ) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        return Color(red: r, green: g, blue: b)
    }
    
    
    //Create default categories
    private func createDefaultCategories() {
        
        //Expense categories
        let expenseCategories: [(name: String, icon: String, color: String)] = [
            ("Health", "heart.fill", "#FF0000"),
            ("Leisure", "gamecontroller.fill", "#9932CC"),
            ("Home", "house.fill", "#A52A2A"),
            ("Cafe", "cup.and.saucer.fill", "#FFA500"),
            ("Education", "book.fill", "#0000FF"),
            ("Gifts", "gift.fill", "#FF69B4"),
            ("Groceries", "cart.fill", "#008000"),
            ("Family", "person.3.fill", "#00FFFF"),
            ("Workout", "figure.run", "#4B0082"),
            ("Transport", "car.fill", "#008080"),
            ("Other", "ellipsis.circle.fill", "#808080")
        ]
        
        //Income categories
        let incomeCategories: [(name: String, icon: String, color: String)] = [
            ("Salary", "dollarsign.circle.fill", "#008000"),
            ("Interest", "percent", "#0000FF"),
            ("Part-time", "clock.fill", "#FFA500"),
            ("Bonus", "star.fill", "#FFD700"),
            ("Gift", "gift.fill", "#FF69B4"),
            ("Other", "ellipsis.circle.fill", "#808080")
        ]
        
        
        //Add expense categories
        for category in expenseCategories {
            let newCategory = Category(context: viewContext)
            newCategory.id = UUID()
            newCategory.name = category.name
            newCategory.icon = category.icon
            newCategory.colorHex = category.color
            newCategory.isExpense = true
            newCategory.isDefault = true
        }
        
        //Add income categories
        for category in incomeCategories {
            let newCategory = Category(context: viewContext)
            newCategory.id = UUID()
            newCategory.name = category.name
            newCategory.icon = category.icon
            newCategory.colorHex = category.color
            newCategory.isExpense = false
            newCategory.isDefault = true
        }
        
        saveCategory()
        fetchCategories()
        
    }


}
