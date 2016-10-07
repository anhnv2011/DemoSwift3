//
//  MonAn.swift
//  MonAnNgayTet
//
//  Created by DangCan on 2/4/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import Foundation
import UIKit
class MonAn {
    var name : String?
    var photo :  UIImage?
    init (name: String, photo: String)
    {
        self.name = name
        self.photo = UIImage(named: "\(photo).jpg")
    }
}