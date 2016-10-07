//
//  ViewController.swift
//  UIPopoverPresentation
//
//  Created by PJ Vea on 5/13/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //segue for the popover configuration window
        if segue.identifier == "showView" {
            let controller = segue.destination
            controller.popoverPresentationController!.delegate = self
                controller.popoverPresentationController?.backgroundColor = UIColor.white
            controller.preferredContentSize = CGSize(width: 220, height: 30)
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .none
    }
    
}

