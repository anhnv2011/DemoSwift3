//
//  ViewSongs.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewSongs: UITableViewControllerBase{
    var listViewPlaylist = ListView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), style: .plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("")
        getArtistWithSongID()
        addListViewPlaylist()
        setupListView()
        loadTitle(currentIndexOption)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    override func setupListView()
    {
        labels = getAllSongOrder()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.songs
    }
    
    //Interface
    func addListViewPlaylist()
    {
        listViewPlaylist.backgroundColor = UIColor.black
        listViewPlaylist.delegateSelectItem = self
        listViewPlaylist.type = Type.playlist
        listViewPlaylist.items = getPlayList()
        myTableView.addSubview(listViewPlaylist)
        setStateForListViewPlaylist()
    }
    func setStateForListViewPlaylist()
    {
        listViewPlaylist.isHidden = !listViewPlaylist.isHidden
        
    }
//# MARK: process data from database
    func getPlayList() -> [Label]
    {
        var labels = [Label]()
        let dicts = dataBase.viewDatabase("PlayList", columns: ["*"], statement: "")
        for item in dicts
        {
            labels.append(Label(displayName: item["PlaylistName"] as! String, id: item["ID"] as! Int, column: "PlaylistName"))
        }
        return labels
    }
    func getDataSong(_ statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("SONGS", columns: ["*"], statement: statement)
        super.myTableView.reloadData()
    }
    func getAllSongOrder() -> [Label]
    {
        return [Label(displayName: "Name", id: 1, column: "SongName"), Label(displayName: "ID", id: 2, column: "ID")]
    }
    func getCurrentObject(_ currentItem: NSDictionary) -> NSObject
    {
        return Song(id: currentItem["ID"] as! Int, songName: currentItem["SongName"] as! NSString, urlImg: currentItem["UrlImg"] as! NSString)
    }
    
  
    
}

extension ViewSongs: SelectItem
{
    //# MARK: Delegate Select ListView
    func selectSongsOption(_ id: Int) {
        currentIndexOption = id
        loadTitle(id)
        self.getDataSong("Order by \(labels[id - 1].column!) ASC")
    }
    func selectButtonAddPlayList(_ id: Int, point: CGPoint)
    {
        listViewPlaylist.frame.origin = point
        self.indexSong = id
        setStateForListViewPlaylist()
        myTableView.isScrollEnabled = !myTableView.isScrollEnabled
    }
    func selectPlayList(_ id: Int) {
        myTableView.isScrollEnabled = true
        self.listViewPlaylist.deselectRow(at: listViewPlaylist.indexPathForSelectedRow!, animated: true)
        let currentSong = items[self.indexSong]
        dataBase.insertDatabase("DETAILPLAYLIST", dict: ["SongID":String(describing: currentSong["ID"]!), "PlayListID":String(id)])
    }
}

extension ViewSongs: UITextFieldDelegate
{
    //# MARK: Textfield delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var statement = ""
        //Trường hợp string == "" nghĩa là đang xoá
        if (string == "")
        {
            //Lớn hơn không mới cắt để tránh lỗi
            if (textField.text!.characters.count > 0)
            {
                statement = (textField.text! as NSString).substring(to: textField.text!.characters.count - 1)
            }
            else
            {
                statement = ""
            }
        }
            //trường hợp tăng string lên
        else
        {
            statement = "\(textField.text!)\(string)"
        }
        self.getDataSong("Where SongName Like '\(statement)%'")
        return true
    }

}

extension ViewSongs: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "UITableViewCellBase", bundle: nil) , forCellReuseIdentifier: "Cell")
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCellBase
        let currentItem = items[(indexPath as NSIndexPath).row]
        cell!.object = getCurrentObject(currentItem)
        cell!.type = Type.songs
        cell!.delegateSelect = self
        if nameArtists.count == items.count
        {
            cell?.nameItem = nameArtists[(indexPath as NSIndexPath).row]
        }
        
        cell?.changeInfo()
        return cell!
    }

}

extension ViewSongs: UITableViewDelegate
{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 84
    }
    
}
