//
//  JournalController.swift
//  Speak in
//
//  Created by Irene Woo on 10/8/16.
//  Copyright © 2016 Irene Woo. All rights reserved.
//

import UIKit

class JournalController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    struct MyData {
        var play_button:String//modify?
        var title_label:String
        var date_label:String
        var blurb_label:String
        var percentage_label:String
        
    }
    
    // Reference to table view
    @IBOutlet weak var table_view: UITableView!
    
    var tableData : [MyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.table_view.delegate = self;
        self.table_view.dataSource = self;
        
        
        tableData = [
            MyData(play_button: "Something", title_label: "Entry 1", date_label:"10/06/16", blurb_label:"My day was fine.", percentage_label:"50%")]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToEntryController(segue: UIStoryboardSegue) {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath as IndexPath) as! TableCell
        
        
        cell.play_button.setTitle(tableData[0].play_button, for: UIControlState.normal)
        cell.title_label.text = tableData[0].title_label
        cell.date_label.text = tableData[0].date_label
        cell.blurb_label.text = tableData[0].blurb_label
        cell.percentage_label.text = tableData[0].percentage_label
        
        return cell
    }
    
}
