//
//  Option.swift
//  MicrosoftWord
//
//  Created by DangCan on 2/1/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
class OptionFont {
    static let sharedInstance = OptionFont()
    private init() {}
    var size: Int?
    var fontName: String?
    var color: UIColor?
    var alignment: Int!
    init (size: Int, fontName: String, color: UIColor, alignment: Int)
    {
        self.size = size
        self.fontName = fontName
        self.color = color
        self.alignment = alignment
    }
    
}
