//
//  BaseController.swift
//  iHotel
//
//  Created by DangCan on 3/14/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import Foundation
import UIKit
class BaseController: UIViewController {
    override func viewDidLoad() {
        //add button to navigation bar
        let btnHome = UIButton()
        btnHome.setImage(UIImage(named: "home"), forState: .Normal)
        btnHome.frame = CGRectMake(0, 0, 30, 30)
        btnHome.addTarget(self, action: #selector(BaseController.PushBackHomeView), forControlEvents: .TouchUpInside)
        //.... Set Right/Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnHome
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "back"), forState: .Normal)
        btnBack.frame = CGRectMake(0, 0, 30, 30)
        btnBack.addTarget(self, action: #selector(BaseController.PushBack), forControlEvents: .TouchUpInside)
        //.... Set Right/Left Bar Button item
        let backBarButton = UIBarButtonItem()
        backBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItems = [backBarButton,leftBarButton]
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 4/255, green: 190/255, blue: 231/255, alpha: 1)
        self.navigationController?.navigationBar.translucent = false

    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    //func navigation bar
    func PushBackHomeView()
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func PushBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
}