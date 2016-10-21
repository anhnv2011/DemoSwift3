//
//  Enumeration.swift
//  DemoSwift3
//
//  Created by Techmaster on 10/6/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

enum MIMEType: String {
    case json = "application/json"
    case pdf = "application/pdf"
    case png = "image/png"
    case jpg = "image/jpg"
}

enum Character {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    case Thief
    case Warrior
    case Knight
}

class Enumeration: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }



}
