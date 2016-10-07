//
//  ViewArtists.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewArtists: UITableViewControllerBase{
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("")
        setupListView()
        loadTitle(currentIndexOption)
    }
    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupListView()
    }
    override func setupListView()
    {
        labels = getALlArtistOrder()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.artists
    }
    func getDataSong(_ statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("ARTISTS", columns: ["*"], statement: statement)
        super.myTableView.reloadData()
    }
    func getALlArtistOrder() -> [Label]
    {
        return [Label(displayName: "Name", id: 1, column: "ArtistName")]
    }
    
    
    
    //
    func getCurrentObject(_ currentItem: NSDictionary) -> NSObject
    {
        return Artist(id: currentItem["ID"] as! Int, artistName: currentItem["ArtistName"] as! NSString,  born: currentItem["Born"] as! NSString, urlImg: currentItem["UrlImg"] as! NSString)
    }
    
}


extension ViewArtists: UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "UITableViewCellBase", bundle: nil) , forCellReuseIdentifier: "Cell")
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "Cell") as? UITableViewCellBase
        let currentItem = items[(indexPath as NSIndexPath).row]
        cell!.object = getCurrentObject(currentItem)
        cell!.type = Type.artists
        //        cell!.delegateSelect = self
        if nameArtists.count == items.count
        {
            cell?.nameItem = nameArtists[(indexPath as NSIndexPath).row]
        }
        
        cell?.changeInfo()
        return cell!
    }

}

extension ViewArtists : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 84
    }

}

extension ViewArtists : SelectItem
{
    //delegate
    func selectArtistsOption(_ id: Int) {
        currentIndexOption = id
        loadTitle(id)
        getDataSong("Order by \(labels[id - 1].column!) ASC")
    }

}

extension ViewArtists: UITextFieldDelegate
{
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
        self.getDataSong("Where ArtistName Like '\(statement)%'")
        return true
    }

}
