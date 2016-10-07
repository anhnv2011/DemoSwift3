//
//  PopoverViewController.swift
//  DemoPopover
//
//  Created by HuuLuong on 7/13/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func action_motionReaction(sender: AnyObject) {
        
        switch sender.tag {
        case 1:
            print("Like")
        case 2:
            print("Love")
        case 3:
            print("Haha")
        case 4:
            print("Yay")
        case 5:
            print("Wow")
        case 6:
            print("Sad")
        default:
            print("Angry")
        }
    }
    
    
    

}
