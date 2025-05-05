//
//  PersistenceController.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/5/25.
//

import Foundation
import CoreData

class PersistenceController{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ApplicationDataModel")
        container.loadPersistentStores{description, error in
            if let error = error{
                fatalError("Error: Not able to load CoreData Container : \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext(){
        let context = container.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nsError = error as NSError
                fatalError("Error: Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
