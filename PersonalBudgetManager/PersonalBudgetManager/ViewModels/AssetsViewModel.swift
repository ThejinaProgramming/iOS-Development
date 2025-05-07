//
//  AssetsViewModel.swift
//  PersonalBudgetManager
//
//  Created by user271744 on 5/7/25.
//

import Foundation
import CoreData

class AssetsViewModel: ObservableObject{
    @Published var assets: [Asset] = []
    private var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext){
        self.viewContext = viewContext
        fetchAssets()
    }
    
    func fetchAssets(){
        let request = NSFetchRequest<Asset>(entityName: "Asset")
        
        do{
            assets = try viewContext.fetch(request)
        }catch{
            print("Error fetching categories: \(error.localizedDescription)")
        }
    }
    
    func addAsset(amount: Double){
        let assetItem = Asset(context: viewContext)
        assetItem.id = UUID()
        assetItem.amount = amount
    
        saveAsset()
        objectWillChange.send()
    }
    
    
    
    func deleteAsset(_ assetItem: Asset){
        viewContext.delete(assetItem)
        
        saveAsset()
        objectWillChange.send()
    }
    
    private func saveAsset(){
        PersistenceController.shared.saveContext()
    }
    
    //calculations
    func calculateTotalAssets() -> Double{
        return assets.reduce(0){$0 + $1.amount}
    }
}
