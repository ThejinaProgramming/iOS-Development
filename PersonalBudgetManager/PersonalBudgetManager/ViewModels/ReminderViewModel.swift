//
//  ReminderViewModel.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/5/25.
//

import Foundation
import CoreData

class ReminderViewModel: ObservableObject{
    @Published var reminders: [Reminder] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.viewContext = viewContext
    }
    
    func fetchReminders(){
        let request = NSFetchRequest<Reminder>(entityName: "Reminder")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Reminder.selectedDate, ascending: true)]
        
        do{
            reminders = try viewContext.fetch(request)
        }catch{
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    func addReminder(name: String, frequency: String, date: Date, time: Date, description: String){
        let reminderItem = Reminder(context: viewContext)
        reminderItem.id = UUID()
        reminderItem.reminderName = name
        reminderItem.reminderFrequency = frequency
        reminderItem.selectedDate = date
        reminderItem.selectedTime = time
        reminderItem.notes = description
        reminderItem.isCompleted = false
        
        saveReminder()
        objectWillChange.send()
    }
    
    func deleteReminder(_ reminderItem: Reminder){
        viewContext.delete(reminderItem)
        
        saveReminder()
        objectWillChange.send()
    }
    
    private func saveReminder(){
        PersistenceController.shared.saveContext()
    }
}
