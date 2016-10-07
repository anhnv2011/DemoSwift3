//
//  Cell.swift
//  MonAnNgayTet
//
//  Created by DangCan on 2/4/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    var nameLabel: UILabel!
    var imageViewCell: UIImageView!
    var kCellWidth: CGFloat = 400
    var kCellHeight: CGFloat = 200
    var kLabelHeight: CGFloat = 50
    
    func addSubviews() {
        if (imageViewCell == nil) {
            imageViewCell = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellHeight))
            contentView.addSubview(imageViewCell)
        }
        
        if (nameLabel == nil) {
            nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kLabelHeight))
            nameLabel.textAlignment = .left
            nameLabel.textColor = UIColor.red
            nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            contentView.addSubview(nameLabel)
        }
    }
}
