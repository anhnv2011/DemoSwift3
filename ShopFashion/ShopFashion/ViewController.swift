//
//  ViewController.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "items", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        for dic in (myDict!.allValues as? [[String: Any]])!
        {
            self.items.append(Item(name: dic["name"] as! String, content: dic["content"] as! String, nameImages: dic["images"] as! NSArray as! [String], price: dic["price"] as! String))
        }
        
    }
}
extension ViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACell", for: indexPath) as! ACellItem
        cell.addSubviews()
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.image = UIImage(named: items[(indexPath as NSIndexPath).item].nameImages[0]+".jpg")
        cell.nameLabel.text = items[(indexPath as NSIndexPath).item].name
        cell.price.text = items[(indexPath as NSIndexPath).item].price
        return cell
    }
}
extension ViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewDetailShop") as? ListImages
        listView?.item = items[(indexPath as NSIndexPath).item]
        self.navigationController?.pushViewController(listView!, animated: true)
        
    }
}

