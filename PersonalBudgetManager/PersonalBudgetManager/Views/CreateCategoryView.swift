//
//  CreateCategoryView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var categoryName = ""
    @State private var isExpense: Bool
    @State private var selectedIcon = "circle"
    @State private var selectedColor = Color.blue
    @State private var showingIconPicker = false
    //@State private var selectedIconIndex = 0 // Track selected icon (placeholder)
    
    @ObservedObject var categoryVM: CategoryViewModel
    var onDismiss: () -> Void
    
    init(isExpense: Bool, categoryVM: CategoryViewModel, onDismiss: @escaping () -> Void) {
        self._isExpense = State(initialValue: isExpense)
        self.categoryVM = categoryVM
        self.onDismiss = onDismiss
    }
    
    
    //let icons = Array(repeating: "circle", count: 16) // Placeholder icons
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Create New Category")
                        .font(.title2)
                        .padding(.bottom)
                        .bold()
                    
                    // Category Name
                    Text("Category Name")
                        .bold()
                    TextField("Enter a categorie name", text: $categoryName)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom)
                    
                    // Expense / Income Toggle
                    HStack {
                        Button("Expense") {
                            isExpense = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isExpense ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(isExpense ? .white : .blue)
                        .cornerRadius(10)
                        
                        Button("Income") {
                            isExpense = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!isExpense ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(!isExpense ? .white : .blue)
                        .cornerRadius(10)
                    }
                    .padding(.bottom)
                    
                    // Icon Selection (Placeholder)
                    Text("Icon")
                        .bold()
                    
                    Button(action: {
                        showingIconPicker = true
                    }) {
                        HStack {
                            Image(systemName: selectedIcon)
                                .font(.system(size: 24))
                                .foregroundColor(selectedColor)
                            
                            Text(selectedIcon == "circle" ? "Select an icon" : "Selected: \(selectedIcon)")
                                .foregroundStyle(Color.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding(.bottom)
                    
                    
                    //Color Selection
                    Text("Color")
                        .bold()
                    
                    ColorPicker("Select a color", selection: $selectedColor)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    // Add Button
                    Button("Add Category") {
                        //Convert Color to Hex string
                        let colorHex = categoryVM.hexStringFromColor(UIColor(selectedColor))
                        
                        // Add the new category
                        categoryVM.addCategory(name: categoryName, icon: selectedIcon, colorHex: colorHex, isExpense: isExpense)
                        
                        //Dismiss the view
                        onDismiss()
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(categoryName.isEmpty)
                }
                .padding()
            }
            .navigationDestination(isPresented: $showingIconPicker) {
                IconPickerView(selectedIcon: $selectedIcon)
            }
            .navigationBarTitle("Create Category", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
}

//#Preview {
//    CreateCategoryView()
//}

