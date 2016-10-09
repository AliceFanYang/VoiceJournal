//
//  SingleEntryDetail.swift
//  Speak in
//
//  Created by Gunnar Horve on 10/9/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import UIKit

class SingleEntryDetailController: UIViewController {

    
    @IBOutlet weak var entryHeaderLabel: UINavigationItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryText: UITextView!
    
    var selectedJournalEntryNumber = ""
    var selectedJournalEntry: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.titleLabel.text = self.selectedJournalEntry!.entryTitle
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE',' MMMM dd',' yyyy"        
        self.dateLabel.text = dateFormatter.string(from: self.selectedJournalEntry!.date as Date!)
        self.entryText.text = self.selectedJournalEntry!.entryText
        self.entryHeaderLabel.title = "Entry " + self.selectedJournalEntryNumber
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
