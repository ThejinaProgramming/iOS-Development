//
//  CreateCategoryView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct CreateCategoryView: View {
    @State private var categoryName = ""
    @State private var isExpense = true // Default to Expense
    @State private var isIncome = false
    @State private var selectedIconIndex = 0 // Track selected icon (placeholder)
    
    let icons = Array(repeating: "circle", count: 16) // Placeholder icons
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("Create New Categories")
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
                        isIncome = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isExpense ? Color.gray : Color.gray.opacity(0.2))
                    .foregroundColor(isExpense ? .white : .black)
                    .cornerRadius(10)
                    
                    Button("Income") {
                        isExpense = false
                        isIncome = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isIncome ? Color.gray : Color.gray.opacity(0.2))
                    .foregroundColor(isIncome ? .white : .black)
                    .cornerRadius(10)
                }
                .padding(.bottom)
                
                // Icon Selection (Placeholder)
                Text("Icon")
                    .bold()
                
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    ForEach(0..<icons.count, id: \.self) { index in
                        Button(action: {
                            selectedIconIndex = index
                        }) {
                            Image(systemName: icons[index])
                                .frame(width: 40, height: 40)
                                .background(selectedIconIndex == index ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom)
                
                Spacer()
                // Add Button
                Button("Add") {
                    // Action: Add the new category
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    CreateCategoryView()
}

