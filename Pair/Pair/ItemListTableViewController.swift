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
    }
    


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        var numberOfSections = ListItemController.sharedController.itemList.count / 2
        if numberOfSections % 2 != numberOfSections {
            numberOfSections += 1
        }
        print(numberOfSections)
        return 1//numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numberOfRows = 2
        if section * 2 > ListItemController.sharedController.itemList.count{
            numberOfRows = 1
        }
        return ListItemController.sharedController.itemList.count//numberOfRows
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath)
        let section = indexPath.section
        let row = indexPath.row + 2 * section
        let item = ListItemController.sharedController.itemList[indexPath.row]
        
        cell.textLabel?.text = item.name
        return cell
    }


    


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let itemToBeDeleted = ListItemController.sharedController.itemList[indexPath.row]
            ListItemController.sharedController.deleteListItem(itemToBeDeleted)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


}
