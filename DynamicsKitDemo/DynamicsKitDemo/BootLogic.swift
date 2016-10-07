//
//  BootLogic.swift
//  TechmasterSwiftApp
//
//  Created by Adam on 9/8/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//  Techmaster Vietnam

import UIKit
let SECTION = "section"
let MENU = "menu"
let TITLE = "title"
let CLASS = "class"
class BootLogic: NSObject {
    var menu : NSArray?
    class func boot(_ window:UIWindow){
        let basic = MenuSection(section: "Basic", menus:[
            Menu(title: "Simple Gravity", viewClass: "SimpleGravity"),
            Menu(title: "Attachment", viewClass: "AttachmentCollision"),
            Menu(title: "Two Boxes Attachment", viewClass: "TwoBoxAttachment"),
            Menu(title: "Attach Spring Gravity", viewClass: "AttachSpringGravity"),
            Menu(title: "Snap", viewClass: "Snap"),
            Menu(title: "Draw Handle", viewClass: "DrawHandle")
            ])
        
        
        
        let mainScreen = MainScreen(style: UITableViewStyle.grouped)
        mainScreen.menu = [basic]
        mainScreen.title = "Gesture Recognizer"
        mainScreen.about = "Gesture Recognizer iOS8"
        
        let nav = UINavigationController(rootViewController: mainScreen)
        
        window.rootViewController = nav
        
    }
}
