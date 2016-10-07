//
//  AddView.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/12/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class AddView: UIViewController{
    @IBOutlet weak var lbl_Album: UILabel!
    @IBOutlet weak var lbl_ArtistName: UILabel!
    @IBOutlet weak var lbl_Genre: UILabel!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_ImgName: UITextField!
    let database = DataBase.sharedInstance
    var listView = ListView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
    var labels = [Label]()
    fileprivate var albumID = 0
    fileprivate var artistID = 0
    fileprivate var genreID = 0
    fileprivate var activeList = false
    
//# MARK: Override view
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForLabels()
        addListView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for gesture in self.view.gestureRecognizers!
        {
            if (gesture.isKind(of: UIGestureRecognizer.self))
            {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }
//# MARK: Process Interface
    func setPositionForListView(_ sender: UILabel)
    {
        setStateForListView()
        listView.frame = CGRect(x: sender.frame.origin.x, y: sender.frame.origin.y + sender.frame.height, width: sender.frame.width, height: 100)
        listView.reloadData()
    }
    func addListView()
    {
        listView.delegateSelectItem = self
        setStateForListView()
        self.view.addSubview(listView)
    }
    
    func addGestureForLabels()
    {
        lbl_ArtistName.isUserInteractionEnabled = true
        lbl_Album.isUserInteractionEnabled = true
        lbl_Genre.isUserInteractionEnabled = true
        
        let tapAlbum = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListItemsAlbum))
        lbl_Album.addGestureRecognizer(tapAlbum)
        
        let tapArtist = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListItemsArtist))
        lbl_ArtistName.addGestureRecognizer(tapArtist)
        
        let tapGenre = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListGenre))
        lbl_Genre.addGestureRecognizer(tapGenre)
    }
    func setStateForListView()
    {
        listView.isHidden = !listView.isHidden
    }
    
//# MARK: Process Data
    func viewListItemsArtist()
    {
        labels.removeAll()
        var allArtists = [NSDictionary]()
        var statement = ""
        if (albumID == 0)
        {
            allArtists = database.viewDatabase("ARTISTS", columns: ["ID", "ArtistName"], statement: statement)
        }
        else
        {
            statement =  "JOIN ARTISTS On DETAILALBUM.ArtistID = ARTISTS.ID Where DETAILALBUM.albumID = \(albumID)"
            allArtists = database.viewDatabase("DETAILALBUM", columns: ["ARTISTS.ArtistName", "ARTISTS.ID"], statement: statement)
        }
        
        for artist in allArtists {
            labels.append(Label(displayName: artist["ArtistName"] as! String, id: artist["ID"] as! Int, column: "ArtistName"))
        }
        listView.items = labels
        listView.type = Type.artists
        setPositionForListView(lbl_ArtistName)
    }
    func viewListItemsAlbum()
    {
        labels.removeAll()
        var allAlbums = [NSDictionary]()
        var statement = ""
        if (artistID == 0)
        {
            allAlbums = database.viewDatabase("ALBUMS", columns: ["ID", "AlbumName"], statement: statement)
        }
        else
        {
            statement =  "JOIN ALBUMS On DETAILALBUM.AlbumID = ALBUMS.ID Where DETAILALBUM.artistID = \(artistID)"
            allAlbums = database.viewDatabase("DETAILALBUM", columns: ["ALBUMS.AlbumName", "ALBUMS.ID"], statement: statement)
        }
        
        for album in allAlbums {
            labels.append(Label(displayName: album["AlbumName"] as! String, id: album["ID"] as! Int, column: "AlbumName"))
        }
        listView.items = labels
        listView.type = Type.albums
        setPositionForListView(lbl_Album)
    }
    func viewListGenre()
    {
        labels.removeAll()
        let allGenres = database.viewDatabase("GENRES", columns: ["ID", "GenreName"], statement: "")

        for genre in allGenres {
            labels.append(Label(displayName: genre["GenreName"] as! String, id: genre["ID"] as! Int, column: "GenreName"))
        }
        listView.items = labels
        listView.type = Type.genre
        setPositionForListView(lbl_Genre)
    }
    func insertSong()
    {
        database.insertDatabase("SONGS", dict: ["SongName":"\(txt_Name.text!)", "UrlImg":"\(txt_ImgName.text!).jpg"])
        let songID = database.viewDatabase("SONGS", columns: ["Count(ID)"], statement: "").first!["Count(ID)"] as! Int
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"\(self.albumID)", "GenreID":"\(self.genreID)", "ArtistID":"\(self.artistID)", "SongID":"\(songID)"])
    }
    func getIdArtistWithName(_ name: String)
    {
        
        print(database.viewDatabase("ARTISTS", columns: ["*"], statement: "Where ARTISTS.ArtistName='\(name)'"))
        print("")
    }
    
    func getTitleWithID(_ index: Int) -> String?
    {
        for label in labels
        {
            if (label.id == index)
            {
                return label.displayName
            }
        }
        return nil
    }
    
//# MARK: Action
    @IBAction func action_Create(_ sender: AnyObject) {
        if (checkRequirement())
        {
            insertSong()
            self.dismiss(animated: true, completion: nil)
            
        }
        else
        {
            print("Please Enter All The Required")
        }
        
    }
    func checkRequirement() -> Bool
    {
        if (albumID == 0 || artistID == 0 || genreID == 0 || txt_Name.text == "" || txt_ImgName.text == "")
        {
            return false
        }
        return true
    }
    @IBAction func action_Cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setStateForListView()
    }
    
    }


//# MARK: Delegate Select
extension AddView: SelectItem
{
    func selectGenre(_ id: Int)
    {
        self.genreID = id
        setTitleForLabel(lbl_Genre, title: getTitleWithID(id)!)
    }
    func selectAlbumsOption(_ id: Int) {
        self.albumID = id
        setTitleForLabel(lbl_Album, title: getTitleWithID(id)!)
    }
    func selectArtistsOption(_ id: Int) {
        self.artistID = id
        setTitleForLabel(lbl_ArtistName, title: getTitleWithID(id)!)
    }
    func setTitleForLabel(_ sender: UILabel, title: String)
    {
        sender.text = title
    }

}
