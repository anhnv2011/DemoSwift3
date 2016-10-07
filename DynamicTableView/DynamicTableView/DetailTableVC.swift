//
//  DetailTableVC.swift
//  DynamicTableView
//
//  Created by hoangdangtrung on 12/25/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class DetailTableVC: UITableViewController {
    
    var stringTitle: String!
    var dictData = NSDictionary()
    var arrayKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDataWithName(stringTitle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = stringTitle

    }
    
    func createDataWithName(_ title: String) {
        var path: String = ""
        if (title == "Fruits") {
            path = Bundle.main.path(forResource: "FruitsList", ofType: "plist")!
        }
        if (title == "Animals") {
            path = Bundle.main.path(forResource: "AnimalsList", ofType: "plist")!

        }
        dictData = NSDictionary(contentsOfFile: path)!
        
        arrayKeys = dictData.allKeys as! [String]
        
        arrayKeys = arrayKeys.sorted()
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayKeys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let key: String = arrayKeys[(indexPath as NSIndexPath).row] as String
        cell.textLabel!.text = key
        cell.imageView?.image = UIImage(named: "\(dictData[key]!)")
        
        return cell
    }
    

}











