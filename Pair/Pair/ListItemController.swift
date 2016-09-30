//
//  ListItemController.swift
//  Pair
//
//  Created by Austin Blaser on 9/30/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

class ListItemController {
    
    static let sharedController = ListItemController()
    
    private(set) var itemList: [ListItem] = []
    
    init(){
        
    }
    
    // MARK: - ListItem
    func addMockData(){
        if itemList.count == 0{
            self.createListItem("Austin")
            self.createListItem("Bill")
            self.createListItem("Megan")
        }
    }
    
    func createListItem(name: String){
        guard let newItem = ListItem(name: name) else {return}
        self.itemList.append(newItem)
        saveToPersistedStorage()
    }
    
    func deleteListItem(item: ListItem){
        guard let moc = item.managedObjectContext,
            let index = itemList.indexOf(item) else { return}
        moc.deleteObject(item)
        self.itemList.removeAtIndex(index)
        saveToPersistedStorage()
    }
    
    func randomizeEntries(){
        
        
    }
    
    
    // MARK: - Persistence
    func loadFromPersistedStorage(){
        
        let fetchRequest = NSFetchRequest(entityName: ListItem.recordType)
        let sortDescriptors = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptors]
        let moc = Stack.sharedStack.managedObjectContext
        self.itemList = (try? moc.executeFetchRequest(fetchRequest)) as? [ListItem] ?? []
        
    }
    
    func saveToPersistedStorage(){
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            _ = try moc.save()
        } catch {
            print("Error saving to persisted storage.")
        }
        
    }
    
    
    
}
