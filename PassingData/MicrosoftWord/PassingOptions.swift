//
//  PassingOptions.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
protocol OptionDelegate {
    func setColor(_ colorName: UIColor);
}
class PassingOptions: UIViewController {
    @IBOutlet weak var currentFontName: UITextField!
    @IBOutlet weak var currentSize: UITextField!
    @IBOutlet weak var currentColor: UILabel!
    @IBOutlet weak var currentAlign: UILabel!
    
    var delegate : OptionDelegate! = nil
    var colorLabelText : String! = nil
    var option :  OptionFont!
    var completion: ((_ para1: String, _ para2: String) -> (Void))?
    override func viewDidLoad() {
        currentFontName.text = option.fontName
        currentSize.text = String(option.size!)
        currentColor.backgroundColor = option.color
        var align = ""
        switch(option.alignment)
        {
            case 0: align = "Lef"
            case 1: align = "Cen"
            case 2: align = "Rig"
            default: break
        }
        currentAlign.text = align
    }
    override func viewWillDisappear(_ animated: Bool) {
        //using singleton
        let option = OptionFont.sharedInstance
        option.size = Int(currentSize.text!)
        option.fontName = currentFontName.text
        self.completion!("1", "2")
    }
    
    //using delegate
    @IBAction func touchUpInsideSelectedColor(_ sender: UIButton) {
        if let color = sender.backgroundColor {
            currentColor.backgroundColor = color
            delegate.setColor(color)
        }
    }
    
    
    //using notificationCenter
    @IBAction func touchUpInsideSystemFont(_ sender: UIButton) {
        currentAlign.text = sender.titleLabel?.text
        let dic: NSDictionary = ["Align": sender.tag - 100]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Alignment"), object: nil, userInfo: dic as? [AnyHashable: Any])
    }
    
    //using Block
    func setStyle(_ completion: ((_ para1: String, _ para2: String) -> Void)?)
    {
        print("action")
        self.completion = completion
    }
    
    
    
    
    
    
    
    
}
