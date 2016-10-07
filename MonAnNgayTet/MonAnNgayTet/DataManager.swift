//
//  DataManager.swift
//  MonAnNgayTet
//
//  Created by DangCan on 2/4/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import Foundation
class DataManager {
    static let instance = DataManager()

    var data = NSMutableArray()
    private init() {
        let filePath = Bundle.main.path(forResource: "CacMonAn", ofType: "plist")
        let raw = NSDictionary(contentsOfFile: filePath!)
        let temp = NSMutableArray(capacity: raw!.count)
        for item in raw!
        {
            let monAn = MonAn(name: (item.value as AnyObject).value(forKey: "name") as! String, photo: (item.value as AnyObject).value(forKey: "photo") as! String)
            temp.add(monAn)
        }
        data = NSMutableArray(array: temp)
    }
   
 }
