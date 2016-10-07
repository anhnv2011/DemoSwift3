//
//  ViewController.swift
//  Push
//
//  Created by Tuuu on 5/24/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func action_push(_ sender: AnyObject) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "V2") as? V2
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

