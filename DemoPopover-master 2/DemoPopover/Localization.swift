//
//  Localization.swift
//  DemoPopover
//
//  Created by Tuuu on 7/30/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import Foundation
import UIKit
public func lacalize(key: String) -> String
{
    return Localization.sharedInstance.localizedStringForKey(key)
}
class Localization: NSObject {
    class var sharedInstance: Localization
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Localization? = nil
        }
        dispatch_once(&Static.onceToken)
        {
            Static.instance = Localization()
        }
        return Static.instance!
    }
    var preferredBundle: NSBundle!
    var preferredLanguage: String!
    
    func localizedStringForKey(key: String) -> String
    {
        var result: String!
        if (self.preferredBundle != nil)
        {
            result = self.preferredBundle.localizedStringForKey(key, value: nil, table: nil)
        }
        if (result == nil)
        {
            result = key
        }
        return result
    }
    func setPreferred(preferred: String)
    {
        self.preferredLanguage = preferred
        let bundlePath: NSString! = NSBundle.mainBundle().pathForResource("Localizable", ofType: "strings", inDirectory: nil, forLocalization: preferred)
        self.preferredBundle = NSBundle.init(path: bundlePath.stringByDeletingLastPathComponent)
    }
    
}