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
    
    let realm = try! Realm()
    var tableData: Results<JournalEntry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableData = self.realm.objects(JournalEntry.self)
        self.table_view.delegate = self
        self.table_view.dataSource = self
//        self.table_view.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    @IBAction func unwindToJournalController(segue: UIStoryboardSegue) {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData!.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modIndex = tableData!.count - 1 - indexPath.row;
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        cell.title_label.text = tableData![modIndex].entryTitle
        cell.blurb_label.text = tableData![modIndex].entryText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M'/'d"
        cell.date_label.text = dateFormatter.string(from: tableData![modIndex].date as Date!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let modIndex = self.tableData!.count - 1 - indexPath.row;
            try! self.realm.write {
                self.realm.delete(self.tableData![modIndex]) // get object to delete and put object
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetailSegue") {
            let index = self.tableData!.count - 1 - self.table_view!.indexPathForSelectedRow!.row
            let viewController = segue.destination as! SingleEntryDetailController
            viewController.selectedJournalEntryNumber = "\(index + 1)"
            viewController.selectedJournalEntry = self.tableData![index]
        }
    }
    
}
