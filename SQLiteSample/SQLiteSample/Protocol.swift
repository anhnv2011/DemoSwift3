//
//  Protocol.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/16/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import CoreGraphics
enum Type {
    case songs
    case albums
    case artists
    case playlist
    case genre
    case cell
    case none
}
@objc protocol SelectItem
{
    @objc optional func selectPlayList(_ id: Int)
    @objc optional func selectSongsOption(_ id: Int)
    @objc optional func selectAlbumsOption(_ id: Int)
    @objc optional func selectArtistsOption(_ id: Int)
    @objc optional func selectGenre(_ id: Int)
    @objc optional func selectButtonAddPlayList(_ id: Int, point: CGPoint)
}
