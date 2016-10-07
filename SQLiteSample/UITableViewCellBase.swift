//
//  UITableViewCellBase.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/11/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class UITableViewCellBase: UITableViewCell {
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var btn_addList: UIButton!
    @IBOutlet weak var layout_btnPlay: NSLayoutConstraint!
    
    var delegateSelect:SelectItem!
    let database = DataBase.sharedInstance
    var nameItem = ""
    var type = Type.none
    var object: NSObject!
    var checkAddItemsToCell = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code common to all your cells goes here
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.black
    }
    func changeInfo()
    {
        switch type {
        case Type.songs:
            changeInfoSong()
            break
        case Type.artists:
            changeInfoArtist()
            break
        case .playlist:
            changeInfoPlaylist()
            break
        default:
            break
        }
    }
    func changeInfoSong()
    {
        if let song = object as? Song
        {
            name.text = String(song.songName)
            info.text = nameItem
            imgDetail.image = UIImage(named: song.urlImg as String)
        }
    }
    func changeInfoArtist()
    {
        btn_Play.isHidden = true
        btn_addList.isHidden = true
        if let artist = object as? Artist
        {
            name.text = String(artist.artistName)
            info.text = String(artist.born)
            imgDetail.image = UIImage(named: artist.urlImg as String)
        }
    }
    func changeInfoPlaylist()
    {
        btn_addList.isHidden = true
        layout_btnPlay.constant = 8
        if let playlist = object as? PlayList
        {
            name.text = String(playlist.song.songName)
            info.text = nameItem
            imgDetail.image = UIImage(named: playlist.song.urlImg as String)
        }
    }
    @IBAction func playSong(_ sender: UIButton)
    {
        print("Play")
    }
    @IBAction func addSongToPlaylist(_ sender: UIButton)
    {
        //Trục X lấy toạ độ từ phải qua trái do mình layout
        //Trục Y phải + thêm 8 vì layout mình cách lề trên 8 đơn vị mặc định.
        let originPoint = CGPoint(x: self.frame.width - sender.frame.origin.x - 200, y: sender.frame.origin.y + sender.frame.height + 8)
        let point = self.convert(originPoint, to: self.superview!)
        self.delegateSelect.selectButtonAddPlayList!(Int(point.y)/86, point: point)
    }
    @IBAction func getInfo(_ sender: UIButton)
    {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        
    }
    
}
