//
//  UITableViewControllerBase.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class UITableViewControllerBase: UIViewControllerBase{
    @IBOutlet weak var myTableView: UITableView!
    var indexSong = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.backgroundColor = UIColor.black
        myTableView.separatorColor = UIColor.clear
    }
    
    func getArtistWithSongID()
    {
        for song in items {
            let detail = dataBase.viewDatabase("DETAILALBUM", columns: ["ARTISTS.ArtistName"], statement: "JOIN ARTISTS On DETAILALBUM.ArtistID = ARTISTS.ID Where SongID = \(song["ID"]!)")
            nameArtists.append(detail.first!["ArtistName"] as! String)
        }
    }
}
