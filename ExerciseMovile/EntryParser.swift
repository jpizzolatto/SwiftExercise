//
//  EntryParser.swift
//  ExerciseMovile
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class EntryParser: NSObject {

    static func GetListOfEntries() -> [Entry] {
        
        var entryList : [Entry] = []
        
        let path = NSBundle.mainBundle().pathForResource("exTest", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: path!, options: nil, error: nil)
        
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: nil) as? NSDictionary
        
        if let response = jsonDict!["responseData"] as? NSDictionary,
            feed = response["feed"] as? NSDictionary,
            entries = feed["entries"] as? NSArray {
                
                for e in entries {
                    let myEntry = Entry.CreateEntry(e as! NSDictionary)
                    entryList.append(myEntry)
                }
        }
        
        return entryList
    }
    
}
