//
//  ViewController.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OptionDelegate {
    
    @IBOutlet weak var txt_View: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_View.textColor = UIColor.black
    }
    // Called from the PassingOptions controller via delegation
    func setColor(_ color: UIColor) {
        txt_View.textColor = color
    }
    
    //Called from the PassingOptions controller via NotificationCenter
    func alignment(_ notification: Notification) {
        //deal with notification.userInfo
        if let info = (notification as NSNotification).userInfo as? Dictionary<String,Int> {
            // Check if value present before using it
            if let value = info["Align"] {
                txt_View.textAlignment = NSTextAlignment(rawValue: value)!
                print(value)
            }
            else {
                print("no value for key\n")
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //using singleton
        let option = OptionFont.sharedInstance
        if let size = option.size
        {
            if let name = option.fontName
            {
                txt_View.font = UIFont(name: name, size: CGFloat(size))
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Options") {
            let destination = segue.destination as! PassingOptions
            //using strong counpling
            destination.option = OptionFont(size: Int((txt_View.font?.pointSize)!), fontName: (txt_View.font?.fontName)!, color: txt_View.textColor!, alignment: txt_View.textAlignment.rawValue)
            //using delegate
            destination.delegate = self
            
            //using NotificationCenter
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.alignment(_:)), name: NSNotification.Name(rawValue: "Alignment"), object: nil)
            
            
            
            
            
            //using Block
            destination.setStyle({ (para1, para2) -> Void in
                print("p1:\(para1) p2:\(para2)")
            })
            
            
            
            
            
            
        } else {
            print("Unknown segue")
        }
    }
    
}

