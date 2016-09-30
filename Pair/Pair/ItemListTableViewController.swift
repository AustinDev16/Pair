//
//  ItemListTableViewController.swift
//  Pair
//
//  Created by Austin Blaser on 9/30/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pair Randomizer"
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateTableView), name: "itemListUpdated", object: nil)
        
        ListItemController.sharedController.loadFromPersistedStorage()
        ListItemController.sharedController.addMockData() // only if nothing returned from fetch
       
    }
    
    func updateTableView(){
        self.tableView.reloadData()
    }
    // MARK: - Actions
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        
        let newItemAlertController = UIAlertController(title: "New item", message: nil, preferredStyle: .Alert)
        newItemAlertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New item"
            textField.returnKeyType = .Done
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let add = UIAlertAction(title: "Add", style: .Default) { (_) in
            
            let textField = newItemAlertController.textFields?.first
            guard let text = textField?.text where text.characters.count > 0 else { return }
            
            ListItemController.sharedController.createListItem(text)
            
        }
        
        newItemAlertController.addAction(cancel)
        newItemAlertController.addAction(add)
        self.presentViewController(newItemAlertController, animated: true, completion: nil)
    }
    
    @IBAction func randomizeButtonTapped(sender: AnyObject) {
        
        ListItemController.sharedController.randomizeEntries()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let items = ListItemController.sharedController.itemList
        var numberOfSections = items.count/2
        if numberOfSections * 2 < items.count {
            numberOfSections += 1
        }
    
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSection(section)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath)
        let indexInArray = indexPathForRowInSectionedTableView(indexPath.section, index: indexPath.row)
        
        let item = ListItemController.sharedController.itemList[indexInArray]
        
        cell.textLabel?.text = item.name
        return cell
    }

    private func rowsInSection(section: Int) -> Int {
        if (section + 1) * 2 > ListItemController.sharedController.itemList.count {
            return 1
        } else {
            return 2
        }
    }
    
    private func indexPathForRowInSectionedTableView(section: Int, index: Int) -> Int {
        let items = ListItemController.sharedController.itemList
        if (section + 1) * 2 > items.count {
            return items.count - 1
        } else {
            return section * 2 + index
        }
    }

    


}
