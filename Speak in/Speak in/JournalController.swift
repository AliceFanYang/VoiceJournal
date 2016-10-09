//
//  JournalController.swift
//  Speak in
//
//  Created by Irene Woo on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import UIKit

class JournalController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Reference to table view
    @IBOutlet weak var table_view: UITableView!
    
    var tableData : [JournalEntry] = [JournalEntry(id: "lol_id", entryTitle: "Tonight, my wife died", date: Date() as NSDate, entryText: "It was a dark and stormy night.  I got anxious.  So I killed her.", emotions: [0.0,0.75,0.0,0.0,0.0])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.table_view.delegate = self;
        self.table_view.dataSource = self;
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    @IBAction func unwindToEntryController(segue: UIStoryboardSegue) {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        cell.title_label.text = tableData[0].entryTitle
        cell.date_label.text = "ignore me"
        cell.blurb_label.text = tableData[0].entryText
        cell.dominantEmotion_label.text = tableData[0].dominantEmotion
        return cell
    }
    
}
