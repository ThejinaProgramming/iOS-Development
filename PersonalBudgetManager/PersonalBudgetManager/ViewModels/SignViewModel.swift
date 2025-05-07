//
//  SignViewModel.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import Foundation
import CoreData

class SignViewModel: ObservableObject{
    @Published var users: [User] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.viewContext = viewContext
        fetchUser()
    }
    
    func fetchUser(){
        let request = NSFetchRequest<User>(entityName: "User")
        
        do{
            users = try viewContext.fetch(request)
        }catch{
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    func addUser(email: String, password: String){
        let signItem = User(context: viewContext)
        signItem.id = UUID()
        signItem.email = email
        signItem.password = password
        
        saveUser()
        fetchUser()
        objectWillChange.send()
    }
    
    private func saveUser(){
        PersistenceController.shared.saveContext()
    }
}
