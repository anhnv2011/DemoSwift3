//
//  DetailViewController.swift
//  FinalDetailMaster
//
//  Created by Vinh The on 7/12/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    var name:String?{
        didSet(name){
            configure()
        }
    }
    
    func configure() {
        if let realName = name {
            if let label = nameLabel {
                label.text = realName
            }
        }
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
