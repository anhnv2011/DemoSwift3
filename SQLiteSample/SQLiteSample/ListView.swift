//
//  ListView.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/21/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ListView: UITableView{
    var items = [Label](){
        didSet {
            self.frame.size = CGSize(width: 200, height: items.count * 50)
        }
    }
    var delegateSelectItem: SelectItem!
    var type = Type.none
    //# MARK: INIT
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
        self.layer.borderColor = UIColor(red: 251/255, green: 125/255, blue: 4/255, alpha: 1.0).cgColor
//        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 251/255, green: 125/255, blue: 4/255, alpha: 1.0).cgColor
//        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
    }
    
    
    func selectOption(_ index: Int)
    {
        switch type {
        case .songs:
            self.delegateSelectItem.selectSongsOption!(items[index].id)
            break
        case .albums:
            self.delegateSelectItem.selectAlbumsOption! (items[index].id)
            break
        case .artists:
            self.delegateSelectItem.selectArtistsOption!(items[index].id)
            break
        case .genre :
            self.delegateSelectItem.selectGenre!(items[index].id)
        case .playlist:
            self.delegateSelectItem.selectPlayList!(items[index].id)
            break
        default:
            self.deselectRow(at: self.indexPathForSelectedRow!, animated: false)
            break
        }
    }
}


extension ListView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.dequeueReusableCell(withIdentifier: "Cell")
        let currentItem = items[(indexPath as NSIndexPath).row]
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .default
        cell?.textLabel?.text = currentItem.displayName
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.black
        
        return cell!
    }

}

extension ListView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectOption((indexPath as NSIndexPath).row)
        self.isHidden = true
    }
}
