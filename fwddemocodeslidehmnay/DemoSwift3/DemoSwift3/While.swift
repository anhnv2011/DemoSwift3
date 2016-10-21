//
//  While.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/16/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

class While: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        let n = 6
        var temp = n
        var result = 1
        while temp > 1 {
            result *= temp
            temp = temp - 1
        }
        writeln("\(n)! = \(result)")
        
        temp = n
        result = 1
        repeat {
            result = result * temp
            temp = temp - 1
            
        } while temp > 1
        writeln("\(n)! = \(result)")
        
        let john = Person.init(name: "Job", age: 20, taxCode: "2123434")
        
        print("John tax code \(john.taxCode)")


    }

}
