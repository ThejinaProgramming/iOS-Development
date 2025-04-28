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
    @State private var category: String = ""
    @State private var date: Date = Date()
    @State private var description: String = ""
    @State private var isCategoryDropdownVisible: Bool = false
    @State private var availableCategories: [String] = ["Food", "Transport", "Entertainment", "Salary", "Other"]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Add Transaction")
                .font(.title2)
                .bold()
                .padding(.bottom)
            
            //Expense, income toggle
            HStack{
                Button(action: {
                    isExpense = true
                }){
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
                }){
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
            
            Text("Category")
                .font(.headline)
            Button(action: {
                isCategoryDropdownVisible.toggle()
            }){
                HStack{
                    Text(category.isEmpty ? "Select category" : category)
                        .foregroundColor(category.isEmpty ? .gray : .black)
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
                    VStack{
                        ForEach(availableCategories, id: \.self){
                            cat in Button(action: {
                                category = cat
                                isCategoryDropdownVisible = false
                            }){
                                Text(cat)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Divider()
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                    .offset(y: 40)
                }
            }
            Text("Date")
                .font(.headline)
            DatePicker(
                "Select Date", selection: $date, displayedComponents: [.date]
            )
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Text("Description (Optional)")
                .font(.headline)
            TextEditor(text: $description)
                .frame(height: 100)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            HStack{
                Button("Delete"){
                    
                }
                .foregroundColor(.red)
                
                Spacer()
            }
            
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

#Preview {
    AddTransactionView()
}
