//
//  EntryParser.swift
//  ExerciseMovile
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class EntryParser: NSObject {

    static func GetListOfEntries(data: NSData) -> [Entry] {
        
        var entryList : [Entry] = []
        
//        let path = NSBundle.mainBundle().pathForResource("exTest", ofType: "json")
//        let jsonData = NSData(contentsOfFile: path!, options: nil, error: nil)
        
        if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary {
            
            if let resData = jsonDict["responseData"] as? NSDictionary,
                feed = resData["feed"] as? NSDictionary,
                entries = feed["entries"] as? NSArray {
                    
                    for e in entries {
                        let myEntry = Entry.CreateEntry(e as! NSDictionary)
                        entryList.append(myEntry)
                    }
            }
        }
        
        return entryList
    }
    
}
