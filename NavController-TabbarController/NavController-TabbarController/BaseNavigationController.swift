//
//  BaseNavigationController.swift
//  NavController-TabbarController
//
//  Created by Vinh The on 7/16/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white,
                                             NSFontAttributeName : UIFont.init(name: "SFUIText-Semibold", size: 24)!]
        navigationBar.tintColor = UIColor.white
    }
    
}

