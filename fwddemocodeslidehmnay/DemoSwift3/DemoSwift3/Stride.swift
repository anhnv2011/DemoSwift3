//
//  Stride.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/16/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

class Stride: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stride: chạy vòng lặp theo bước khác 1
        var n = 0
        writeln("Increase")
        for i in stride(from: 0, through: 10, by: 2) {
            n += 1
            writeln("\(i) : \(n)")
        }
        writeln("Decrease")
        for i in stride(from: 10, through: 0, by: -2) {
            writeln("\(i)")
        }
        
        
    }

    
}
