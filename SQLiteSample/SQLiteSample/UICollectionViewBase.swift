//
//  UICollectionViewBase.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class UICollectionViewBase: UIViewControllerBase {
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.backgroundColor = UIColor.black
    }
    //#MARK: Process Data
    func getAllAlbumOrder() -> [Label]
    {
        return[Label(displayName: "Name", id:1, column: "AlbumName"), Label(displayName:"Date", id:2, column: "ReleaseDate")]
    }
    
}
