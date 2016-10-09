//
//  JournalController.swift
//  Speak in
//
//  Created by Irene Woo on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import UIKit
import RealmSwift

class JournalController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Reference to table view
    @IBOutlet weak var table_view: UITableView!
    
    var tableData: Results<JournalEntry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let realm = try! Realm()
        self.tableData = realm.objects(JournalEntry.self)
        self.table_view.delegate = self;
        self.table_view.dataSource = self;
        
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    @IBAction func unwindToJournalController(segue: UIStoryboardSegue) {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData!.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        cell.title_label.text = tableData![indexPath.row].entryTitle
        cell.date_label.text = "ignore me"

        cell.blurb_label.text = tableData![indexPath.row].entryText

        return cell
    }
    
}
