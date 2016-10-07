//
//  BaseTabbarController.swift
//  NavController-TabbarController
//
//  Created by Vinh The on 7/17/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        delegate = self
        
        //tabBar.barTintColor = UIColor.redColor()
//        tabBar.itemPositioning = .Centered
//        tabBar.itemSpacing = 125
        //[UIColor colorWithRed:0.149 green:0.200 blue:0.255 alpha:1.00]
        //        tabBar.tintColor = UIColor.whiteColor()
        //        tabBar.backgroundImage = UIImage(named: "LOGO")
        //        tabBar.shadowImage = UIImage(named: "Profile")
        //        tabBar.selectionIndicatorImage = UIImage(named: "LOGO")
        
        tabBar.barStyle = .default
        
        tabBar.barTintColor = UIColor(red: 0.149, green: 0.2, blue: 0.255, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 12)!],
                                                         for: UIControlState())
        tabBar.isTranslucent = false

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bookVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YourBookVC") as! YourBookController
        
        let homeVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        
        let profileVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        
        let bookNav = BaseNavigationController(rootViewController: bookVC)
        let homeNav = BaseNavigationController(rootViewController: homeVC)
        let profileNav = BaseNavigationController(rootViewController: profileVC)
        
        settingNavForEachController(bookVC, transparent: true, navTitle: "BOOK", shadow: true, tabbarTitle: "Your Book", image: "Book", selectedImage: "Selected-URBook")
        
        settingNavForEachController(homeVC, transparent: true, navTitle: "HOME", shadow: true, tabbarTitle: "Home",image: "Home", selectedImage: "Selected-Home")
        
        settingNavForEachController(profileVC, transparent: true, navTitle: "PROFILE", shadow: true, tabbarTitle: "Profile", image: "Profile", selectedImage: "Selected-Profile")
        
        viewControllers = [bookNav,homeNav,profileNav]
    }
    
    func settingNavForEachController(_ viewcontroller : BaseViewController, transparent : Bool, navTitle : String, shadow : Bool, tabbarTitle : String, image : String, selectedImage : String)
    {
        viewcontroller.navigationItem.title = navTitle
        
        viewcontroller.tabBarItem = UITabBarItem(title: tabbarTitle,
                                                 image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal),
                                                 selectedImage: UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal))
        
        viewcontroller.tranparentNavigation = transparent
        viewcontroller.shadowNavigationBar = shadow
    }
    
}
