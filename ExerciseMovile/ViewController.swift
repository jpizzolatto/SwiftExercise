//
//  ViewController.swift
//  ExerciseMovile
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var entryList : [Entry] = []
    var favoriteList : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        entryList = EntryParser.GetListOfEntries()
        
        let url = NSURL(string: "https://gist.githubusercontent.com/marcelofabri/a5be8a9a6604a1139011/raw/9e9d7a4f13fa8bb0660bc5b4e14a09595982b9c7/new-pods.json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, _ , error) in
            
            if error == nil {
                
                if let jsonDict = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSDictionary {
                    
                    if let resData = jsonDict["responseData"] as? NSDictionary,
                           feed = resData["feed"] as? NSDictionary,
                           entries = feed["entries"] as? NSArray {
                            
                            for e in entries {
                                let myEntry = Entry.CreateEntry(e as! NSDictionary)
                                self.entryList.append(myEntry)
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                            })
                    }
                }
            }
        }
        task.resume()
        
        tableView.estimatedRowHeight = 55.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! TableViewCell
        
        let entry : Entry = entryList[indexPath.row]
        
        let isFavorite = contains(favoriteList, indexPath.row)
        cell.configureCellFromEntry(entry, isFavorite: isFavorite)
        
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var entry = entryList[indexPath.row]
        
        // Add or remove favorite
        
        var title = "Star"
        if contains(self.favoriteList, indexPath.row) {
            title = "Unstar"
        }
        
        var favoriteAction = UITableViewRowAction(style: .Normal, title: title) { (action, indexPath) -> Void in
            
            tableView.editing = false
            let index = find(self.favoriteList, indexPath.row)
            if index != nil {
                self.favoriteList.removeAtIndex(index!)
            }
            else {
                self.favoriteList.append(indexPath.row)
            }
            self.tableView.reloadData()
        }
        
        if contains(self.favoriteList, indexPath.row) {
            favoriteAction.backgroundColor = UIColor.redColor()
        }
        else {
            favoriteAction.backgroundColor = UIColor.grayColor()
        }
        
        // Add to reading list action
        var readingListAction = UITableViewRowAction(style: .Default, title: "Add to Reading list") { (action, indexPath) -> Void in
            
            let list = SSReadingList.defaultReadingList()
            list.addReadingListItemWithURL(entry.link, title: entry.title, previewText: nil, error: nil)
            
            var alert = UIAlertController(title: "Success", message: "Link added into reading list", preferredStyle: UIAlertControllerStyle.Alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    println("default")
                    
                case .Cancel:
                    println("cancel")
                    
                case .Destructive:
                    println("destructive")
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)

        }
        readingListAction.backgroundColor = UIColor.blueColor()
        
        return [favoriteAction, readingListAction]
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let entry : Entry = entryList[indexPath.row]
        
        UIApplication.sharedApplication().openURL(entry.link)
    }
}

