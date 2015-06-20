//
//  TableViewCell.swift
//  ExerciseMovile
//
//  Created by User on 20/06/15.
//  Copyright (c) 2015 User. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
   
    @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var snippetCell: UILabel!
    
    func configureCellFromEntry(entry : Entry, isFavorite : Bool) -> Void {
        
        var paragraph = entry.contentSnipped
        
        if let breakIndex = paragraph.rangeOfString("\n")?.startIndex {
            
            paragraph = paragraph.substringToIndex(breakIndex)
        }
        
        self.titleCell.text = entry.title
        self.snippetCell.text = paragraph
        
        if  entry.ThisIsTodayEntry() {
            self.titleCell.font = UIFont.boldSystemFontOfSize(17)
            self.snippetCell.font = UIFont.boldSystemFontOfSize(14)
        }
        else {
            self.titleCell.font = UIFont.systemFontOfSize(17)
            self.snippetCell.font = UIFont.systemFontOfSize(14)
        }
        
        if isFavorite {
            self.titleCell.textColor = UIColor.blueColor()
            self.snippetCell.textColor = UIColor.blueColor()
        }
        else {
            self.titleCell.textColor = UIColor.blackColor()
            self.snippetCell.textColor = UIColor.grayColor()
        }
    }
    
}
