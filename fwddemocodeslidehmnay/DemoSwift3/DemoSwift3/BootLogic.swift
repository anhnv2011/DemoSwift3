//
//  BootLogic.swift
//  TechmasterSwiftApp
//  Techmaster Vietnam

import UIKit

class BootLogic: NSObject {
    
    var menu : [MenuSection]!
    class func boot(_ window:UIWindow){
        let control_flow = MenuSection(section: "Control Flow", menus:[
            Menu(title: "For loop", viewClass: "ForLoop"),
            Menu(title: "Stride", viewClass: "Stride"),
            Menu(title: "While", viewClass: "While")
            
            ])
        
        let syntax = MenuSection(section: "Syntax", menus:[
            Menu(title: "Optional", viewClass: "Optional"),
            Menu(title: "Enumeration", viewClass: "Enumeration"),
            Menu(title: "Extension", viewClass: "Extension"),
            Menu(title: "Subscript", viewClass: "Subscript")
            ])


        let oop = MenuSection(section: "Object Oriented Programming", menus:[
            Menu(title: "Declare Class", viewClass: "DeclareClass"),
            Menu(title: "Struct vs Class", viewClass: "StructVsClass"),
            Menu(title: "Adopt Protocol", viewClass: "AdoptProtocol"),
            Menu(title: "Parameter Overload", viewClass: "Parameter")
            ])
        
        let advance = MenuSection(section: "String", menus:[
            Menu(title: "Init, length", viewClass: "StringInitLength"),
            Menu(title: "Home", viewClass: "DemoPan")
            ])
        
        let mainScreen = MainScreen(style: UITableViewStyle.grouped)
        mainScreen.menu = [control_flow, syntax, oop, advance]
        mainScreen.title = "Swift 3"
        mainScreen.about = "Written by Cuong"
        
        let nav = UINavigationController(rootViewController: mainScreen)
        
        window.rootViewController = nav        
      
    }   
}
