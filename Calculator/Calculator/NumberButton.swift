//
//  NumberButton.swift
//  Calculator
//
//  Created by Vinh The on 7/5/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class NumberButton: UIButton {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureButton()
    }
    
    func configureButton() -> Void {
        
        backgroundColor = UIColor.init(red: 49/255, green: 58/255, blue: 75/255, alpha: 1.0)
        
        layer.borderWidth = 0.5
        layer.cornerRadius = 3.0
        layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 0.2).cgColor
        self.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 18)
        
    }
}
