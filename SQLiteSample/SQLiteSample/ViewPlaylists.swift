//
//  ViewPlaylists.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewPlayLists: UITableViewControllerBase{
    var currentID = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("1", statement: "")
        getArtistWithSongID()
        setupListView()
        loadTitle(currentIndexOption)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupListView()
    }
    override func setupListView()
    {
        labels = getPlayList()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.playlist
    }
    func getDataSong(_ id: String, statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("PLAYLIST", columns: ["*"], statement: "JOIN DetailPlayList On PLAYLIST.Id = DetailPlayList.PlayListId JOIN SONGS On SONGS.Id = DetailPlayList.SONGID where PLAYLIST.Id = \(id) \(statement)")
        super.myTableView.reloadData()
    }
        //# MARK:Delegate UITableView
    
    
    //
    func getCurrentObject(_ currentItem: NSDictionary) -> NSObject
    {
        return PlayList(id: currentItem["ID"] as! Int, playListName: currentItem["PlaylistName"] as! NSString, song: Song(id: currentItem["SongID"] as! Int, songName: currentItem["SongName"] as! NSString, urlImg: currentItem["UrlImg"] as! String as NSString))
    }
    
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
   
    
}


extension ViewPlayLists: SelectItem
{
    
    func selectPlayList(_ id: Int) {
        currentIndexOption = id
        loadTitle(id)
        getDataSong(String(id), statement: "")
        getArtistWithSongID()
    }
}

extension ViewPlayLists: UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var name = ""
        //Trường hợp string == "" nghĩa là đang xoá
        if (string == "")
        {
            //Lớn hơn không mới cắt để tránh lỗi
            if (textField.text!.characters.count > 0)
            {
                name = (textField.text! as NSString).substring(to: textField.text!.characters.count - 1)
            }
            else
            {
                name = ""
            }
        }
            //trường hợp tăng string lên
        else
        {
            name = "\(textField.text!)\(string)"
        }
        self.getDataSong(String(currentID), statement: "And SONGS.SongName Like '\(name)%'")
        return true
    }

}

extension ViewPlayLists: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "UITableViewCellBase", bundle: nil) , forCellReuseIdentifier: "Cell")
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCellBase
        let currentItem = items[(indexPath as NSIndexPath).row]
        cell!.object = getCurrentObject(currentItem)
        cell!.type = Type.playlist
        //        cell!.delegateSelect = self
        if nameArtists.count == items.count
        {
            cell?.nameItem = nameArtists[(indexPath as NSIndexPath).row]
        }
        
        cell?.changeInfo()
        return cell!
    }

}

extension ViewPlayLists: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 84
    }
}
