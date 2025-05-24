//
//  CreateRemindersView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct CreateRemindersView: View {
    //let reminder: Reminder
    @ObservedObject var reminderViewModel: ReminderViewModel
    @Binding var showingAddReminderView: Bool
    
    @State private var reminderName: String = ""
    @State private var reminderFrequency: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var description: String = ""
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Create Reminder")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                //Reminder Name
                Text("Reminder Name")
                    .font(.headline)
                TextField("Enter Reminder Name", text: $reminderName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom)
                
                //Reminder Frequency
                Text("Reminder Frequency")
                    .font(.headline)
                Menu{
                    Button("Once"){ reminderFrequency = "Once"}
                    
                } label: {
                    HStack{
                        Text(reminderFrequency.isEmpty ? "Dropdown appears on top" : reminderFrequency)
                            .foregroundColor(reminderFrequency.isEmpty ? .gray: .primary)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                }
                
                Text("Date")
                    .font(.headline)
                DatePicker(
                    "Select Date", selection: $selectedDate, displayedComponents: [.date]
                )
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                Text("Time")
                    .font(.headline)
                DatePicker(
                    "Select Time", selection: $selectedTime, displayedComponents: [.hourAndMinute]
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
                
                Spacer()
                
                HStack{
                    Button("Save"){
                        reminderViewModel.addReminder(name: reminderName, frequency: reminderFrequency, date: selectedDate, time: selectedTime ,description: description)
                        reminderViewModel.fetchReminders()
                        showingAddReminderView = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel"){
                        showingAddReminderView = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

