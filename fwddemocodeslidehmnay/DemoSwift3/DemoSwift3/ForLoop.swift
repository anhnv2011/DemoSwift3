//
//  ForLoop.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/16/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

class ForLoop: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        let array = [10,20,30,40,50]
        //++ is unavailable. It has been removed
        //C-style for statement has been removed
        /*
        for(var i=0 ; i < array.count ;i++){
            writeln("array[i] \(array[i])")
        }*/
        writeln("for in without index")
        for num in array {
           writeln("\(num)")
        }
        
        writeln("for in with index. Must use enumerated")
        for (i, num) in array.enumerated() {
            writeln("array[\(i)] = \(num)")
        }
        
        writeln("forEach")
        array.forEach { (num) in
            writeln("\(num)")
        }
  
        for i in array
        {
            
        }
    }
}
