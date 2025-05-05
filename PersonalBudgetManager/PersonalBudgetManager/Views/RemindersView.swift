//
//  RemindersView.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 4/28/25.
//

import SwiftUI

struct RemindersView: View {
    @ObservedObject var reminderViewModel: ReminderViewModel
    @State private var showingAddReminderView = false
    @State private var showingViewReminderView = false
    
    @State var selectedReminder: Reminder = Reminder()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Reminders")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                List{
                    ForEach(reminderViewModel.reminders){reminder in
                        Button{
                            selectedReminder = reminder
                            showingViewReminderView = true
                        }
                        label:{
                            ReminderRow(title: reminder.reminderName ?? "")
                        }
                    }
                }
                Spacer()
                    .sheet(isPresented: $showingAddReminderView){
                        CreateRemindersView(reminderViewModel: reminderViewModel, showingAddReminderView: $showingAddReminderView)
                    }
                    .sheet(isPresented: $showingViewReminderView){
                        DisplayReminderDetailsView(reminderViewModel: reminderViewModel, showingViewReminderView: $showingViewReminderView, reminder: selectedReminder)
                    }
            }
            .onAppear{
                reminderViewModel.fetchReminders()
            }
            .padding()
            Button{
                showingAddReminderView = true
            }label: {
                Image(systemName: "plus")
                    .font(.title)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
    }
}

