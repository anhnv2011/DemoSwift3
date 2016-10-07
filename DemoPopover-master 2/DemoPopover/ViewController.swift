//
//  ViewController.swift
//  DemoPopover
//
//  Created by HuuLuong on 7/13/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var textView_comment: UITextView!
    
    @IBOutlet weak var btn_Like: UIButton!
    
    @IBOutlet weak var btn_Comment: UIButton!
    
    @IBOutlet weak var btn_Share: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView_comment.layer.borderWidth = 2
        textView_comment.layer.borderColor = UIColor.grayColor().CGColor
        
    }
    
    @IBAction func action_ChangeLanguage(sender: UIButton) {
        multipleLanguages(sender.currentTitle!)
        
    }
    
    
    func multipleLanguages(language: String)
    {
        Localization.sharedInstance.setPreferred(language)
        lbl_Name.text = lacalize("Benjamin Franklin")
        lbl_Date.text = lacalize("July 14 at 10:16 am")
        lbl_Status.text = lacalize("An investment in knowledge pays the best interest.")
        textView_comment.text = lacalize("Write a comment...")
        btn_Like.setTitle(lacalize("Like"), forState: .Normal)
        btn_Share.setTitle(lacalize("Share"), forState: .Normal)
        btn_Comment.setTitle(lacalize("Comment"), forState: .Normal)
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showView" {
            let controller = segue.destinationViewController
            controller.popoverPresentationController?.delegate = self
            controller.preferredContentSize = CGSize(width: 222, height: 30)
            
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }

    //Bắt sự kiện khi tap các button trên popover view
    //Sử dụng thuộc tính Tag để phân biệt giữa các nút
    
    
    
}

