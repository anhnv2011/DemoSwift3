//
//  MasterTableVC.swift
//  DynamicTableView
//
//  Created by hoangdangtrung on 12/25/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class MasterTableVC: UITableViewController {
    
    var dictList = ["Fruits": "fruits.png", "Animals": "animals.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "English 4 Kids"
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var arrKey = [String](dictList.keys)
        var arrValue = [String](dictList.values)
        
        cell.textLabel!.text = arrKey[(indexPath as NSIndexPath).row];
        cell.imageView?.image = UIImage(named: arrValue[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    // ----------------------------------------------------------------------------
    
//    // MRAK: - Table view delegate
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let detailTableVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailTableVC") as! DetailTableVC
//        
//        let selectedRowIndex: NSIndexPath = self.tableView.indexPathForSelectedRow!
//        let selectedCell: UITableViewCell = self.tableView.cellForRowAtIndexPath(selectedRowIndex)!
//        
//        detailTableVC.stringTitle = selectedCell.textLabel!.text!
//        
//        performSegueWithIdentifier("ShowDetail", sender: self)
//    }
    
    // -----------------------------------------------------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueID = segue.identifier
        if(segueID! == "ShowDetail") {
            let detailTableVC: DetailTableVC = segue.destination as! DetailTableVC
            
            let selectedRowIndex: IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedCell: UITableViewCell = self.tableView.cellForRow(at: selectedRowIndex)!
            
            detailTableVC.stringTitle = selectedCell.textLabel!.text!
        }
    }
    
    
}


















