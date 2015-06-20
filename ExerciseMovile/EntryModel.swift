//
//  EntryModel.swift
//  ExerciseMovile
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

let dateStringFormatter = NSDateFormatter()

struct Entry {
    
    let title : String
    let link : NSURL
    let publishedDate : NSDate
    let contentSnipped : String
    let content : String
    
    static func CreateEntry(e: NSDictionary) -> Entry {
        
        // define title
        let title = e["title"] as! String
        
        // define content
        let content = e["content"] as! String
        
        // define content Snipped
        let contentSnipped = e["contentSnippet"] as! String
        
        // define published date
        dateStringFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm::ss Z"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        let d = dateStringFormatter.dateFromString(e["publishedDate"] as! String)
        let date : NSDate = NSDate(timeInterval: 0, sinceDate: d!) as NSDate
        
        // define link
        let link : NSURL = NSURL(string: e["link"] as! String)!
        
        
        let myEntry : Entry = Entry(title: title, link: link, publishedDate: date, contentSnipped: contentSnipped, content: content)
        
        return myEntry
    }
    
    func ThisIsTodayEntry() -> Bool {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        if calendar.isDateInToday(self.publishedDate) {
            return true
        }
        
        return false
    }
    
}
