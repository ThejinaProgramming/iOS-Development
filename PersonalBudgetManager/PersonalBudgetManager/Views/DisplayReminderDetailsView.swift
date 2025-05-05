//
//  DisplayReminderDetailsView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/5/25.
//

import SwiftUI

struct DisplayReminderDetailsView: View {
    @ObservedObject var reminderViewModel: ReminderViewModel
    @Binding var showingViewReminderView: Bool
    
    @ObservedObject var reminder: Reminder
    
    @State private var reminderName: String = ""
    @State private var reminderFrequency: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var description: String = ""
    
    @State private var isDelete: Bool = false
    @State var text: String = ""
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Reminder Details")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                //Reminder Name
                Text("Reminder Name")
                    .font(.headline)
                Text(reminder.reminderName ?? "")
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
                
                
                HStack{
                    Button("Delete"){
                        isDelete.toggle()
                    }
                    .confirmationDialog("Are you sure", isPresented: $isDelete){
                        Button("Delete Reminder", role: .destructive){
                            reminderViewModel.deleteReminder(reminder)
                            reminderViewModel.fetchReminders()
                            showingViewReminderView = false
                            isDelete.toggle()
                        }
                    }
                    message: {
                        Text("You can not undo this action.")
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                }
                Spacer()
                
                HStack{
                    Button("Save"){
                        reminderViewModel.addReminder(name: reminderName, frequency: reminderFrequency, date: selectedDate, time: selectedTime ,description: description)
                        reminderViewModel.fetchReminders()
                        showingViewReminderView = false
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel"){
                        showingViewReminderView = false
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
        .onAppear{
            reminderName = reminder.reminderName ?? ""
        }
    }
}

