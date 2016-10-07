//
//  ListImages.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ListImages: UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameShop: UILabel!
    @IBOutlet weak var contentShop: UITextView!
    var item: Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameShop.text = item.name
        contentShop.text = item.content
        imgProfile.image = UIImage(named: item.nameImages[0]+".jpg")
        imgProfile.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ListImages.tapImg))
        imgProfile.addGestureRecognizer(tap)
    }
    func tapImg()
    {
        pushView(0)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.nameImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACell", for: indexPath) as! ACellItem
        cell.kCellWidth = 60
        cell.kLabelHeight = 0
        cell.kPriceLabelHeight = 0
        cell.addSubviews()
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.image = UIImage(named: item.nameImages[(indexPath as NSIndexPath).item]+".jpg")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        pushView((indexPath as NSIndexPath).item)
        
    }
    func pushView(_ intdex: Int)
    {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? ViewScroll
        listView?.pageImages = item.nameImages
        listView?.currentImgView = intdex
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    
}
