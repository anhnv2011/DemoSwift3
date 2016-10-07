//
//  ViewController.swift
//  MonAnNgayTet
//
//  Created by DangCan on 2/4/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dataManager = DataManager.instance.data
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let monAn = dataManager[(indexPath as NSIndexPath).item] as! MonAn
        cell.kCellWidth = self.view.frame.size.width
        cell.addSubviews()
        cell.imageViewCell.image = monAn.photo
        cell.nameLabel.text = monAn.name
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            dataManager.removeObject(at: (indexPath as NSIndexPath).item)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
