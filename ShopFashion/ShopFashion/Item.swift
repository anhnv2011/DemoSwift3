//
//  Item.swift
//  ShopFashion
//
//  Created by nguyenvantu on 1/15/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String?
    var content: String?
    var nameImages: [String] = []
    var price: String?
    init(name: String, content: String, nameImages: [String], price: String)
    {
        self.name = name
        self.content = content
        self.nameImages = nameImages
        self.price = price
    }
}
