//
//  Extension.swift
//  DemoSwift3
//
//  Created by Techmaster on 10/6/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

extension Double  {
    var km: Double { return self * 1_000.0 }  //Convert km to meters
    var m:  Double { return self }
    var cm: Double { return self / 100.0 }    //Convert cm to meters
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
    
}



class Extension: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneInch = 25.4.mm
        writeln("\(oneInch) meters")
        
        let threeFeet = 3.ft
        writeln("\(threeFeet) meters")
    }


}
