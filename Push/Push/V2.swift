//
//  V2.swift
//  Push
//
//  Created by Tuuu on 5/24/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class V2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action_Pop(_ sender: AnyObject) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
