//
//  ACellItem.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit
class ACellItem: UICollectionViewCell {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    var price: UILabel!
    var kPriceLabelHeight: CGFloat = 30
    var kCellWidth: CGFloat = 100
    var kLabelHeight: CGFloat = 30
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: kCellWidth, height: kCellWidth + kLabelHeight);
    }
    
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            imageView.layer.borderColor = tintColor.cgColor
            imageView.contentMode = .scaleAspectFit
            contentView.addSubview(imageView)
        }
        
        if (nameLabel == nil) {
            nameLabel = UILabel(frame: CGRect(x: 0, y: kCellWidth, width: kCellWidth, height: kLabelHeight))
            nameLabel.textAlignment = .left
            nameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            nameLabel.highlightedTextColor = tintColor
            nameLabel.font = UIFont.systemFont(ofSize: 10)
            nameLabel.numberOfLines = 2
            contentView.addSubview(nameLabel)
        }
        if (price == nil) {
            price = UILabel(frame: CGRect(x: 0, y: kCellWidth + kLabelHeight, width: kCellWidth, height: kPriceLabelHeight))
            price.textAlignment = .left
            price.textColor = UIColor(red: 255/255, green: 116/255, blue: 35/255, alpha: 1)
            price.font = UIFont.boldSystemFont(ofSize: 12)
            contentView.addSubview(price)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }

}
