//
//  SignUpViewController.swift
//  NavController-TabbarController
//
//  Created by Vinh The on 7/16/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var logoTopContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateContraint(logoTopContraint)
    }

    
    func changeBackgroundColor(_ sender : AnyObject) -> Void {
        print("abbb")
    }
}
