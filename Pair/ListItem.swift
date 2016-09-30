//
//  ListItem.swift
//  Pair
//
//  Created by Austin Blaser on 9/30/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


class ListItem: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init?(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext){
        
        guard let entity = NSEntityDescription.entityForName(ListItem.recordType, inManagedObjectContext: context) else { return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
    }
    
    
    static var recordType: String { return "ListItem"}

}
