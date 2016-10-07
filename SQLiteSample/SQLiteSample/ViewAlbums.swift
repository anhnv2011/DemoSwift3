//
//  ViewAlbums.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewAlbums: UICollectionViewBase {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/277, blue: 34/277, alpha: 1.0)
        self.myCollectionView.register(UINib(nibName: "CollectionViewCellALBUM", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        setupListView()
        getData("")
        loadTitle(currentIndexOption)
        
    }
    override func setupListView()
    {
        labels = getAllAlbumOrder()
        self.listView.delegateSelectItem = self
        self.listView.type = Type.albums
        self.listView.items = labels
    }
    //# MARK: Process Data
    func getData(_ statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("ALBUMS", columns: ["*"], statement: statement)
        self.myCollectionView.reloadData()
    }
    
    //
    
}

extension ViewAlbums: SelectItem
{
    func selectAlbumsOption(_ id: Int) {
        currentIndexOption = id
        loadTitle(id)
        self.getData("Order by \(labels[id - 1].column!) ASC")
    }

}

extension ViewAlbums : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellALBUM
        let album = Album(id: items[(indexPath as NSIndexPath).row]["ID"] as! Int, price: items[(indexPath as NSIndexPath).row]["Price"] as! NSString, albumName: items[(indexPath as NSIndexPath).row]["AlbumName"] as! NSString, releaseDate: items[(indexPath as NSIndexPath).row]["ReleaseDate"] as! NSString, urlImg: items[(indexPath as NSIndexPath).row]["UrlImg"] as! String)
        cell.lbl_AlbumName.text = album.albumName  as String
        cell.lbl_ArtistName.text = album.releaseDate as String
        cell.img_Detail.image = UIImage(named: album.urlImg as String)
        return cell
    }

}

extension ViewAlbums : UICollectionViewDelegate
{


}
