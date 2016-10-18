//
//  OperatorsButton.swift
//  Calculator
//
//  Created by anhnguyenviet on 7/5/16.
//  Copyright © 2016 anhnguyenviet. All rights reserved.
//

import UIKit

class OperatorsButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureButton()
    }

    func configureButton() -> Void {
        
        if tag == 101 {
            backgroundColor = UIColor.init(red: 245/255, green: 165/255, blue: 34/255, alpha: 1)
        }else{
            backgroundColor = UIColor.init(red: 116/255, green: 219/255, blue: 110/255, alpha: 1)
        }
        layer.cornerRadius = 3.0
        titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 20)
    }
}
