//
//  ViewController.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/8/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class DataBase{
    static let sharedInstance = DataBase()
    
    var databasePath = NSString()
    private init()
    {
        getPath()
    }
    func getPath()
    {
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        
        let docsDir = NSString(string: dirPaths[0])
        
        databasePath = docsDir.appendingPathComponent(
            "contacts.db") as NSString
    }


    func createDatabase() -> Bool
    {
        let filemgr = FileManager.default
        
        if !filemgr.fileExists(atPath: databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            
            if (contactDB?.open())! {
                let sql_Create_SONGS = "create table if not exists SONGS (ID integer primary key autoincrement, SongName text, UrlImg text)"
                
                let sql_Create_DetailPlayList = "create table if not exists DetailPlayList (SongID integer, PlayListID integer, foreign key (SongID) references SONGS(ID), foreign key (PlayListID) references PLAYLIST(ID), primary key (SongID, PlayListID))"
                
                let sql_Create_PlayList = "create table if not exists PLAYLIST (ID integer primary key autoincrement, PlaylistName text)"
                
                let sql_Create_ALBUMS = "create table if not exists ALBUMS (ID integer primary key autoincrement, Price text, AlbumName text, ReleaseDate text, UrlImg text)"
                
                let sql_Create_DetailAlbum = "create table if not exists DETAILALBUM (AlbumID integer, GenreID integer, ArtistID integer, SongID integer, foreign key (AlbumID) references ALBUMS(ID), foreign key (GenreID) references GENRES(ID), foreign key (ArtistID) references ARTISTS(ID), foreign key (SongID) references SONGS(ID), primary key (AlbumID, GenreID, ArtistID, SongID))"
                
                let sql_Create_ARTISTS = "create table if not exists ARTISTS (ID integer primary key autoincrement, ArtistName text, UrlImg text, Born text not null)"
                
                let sql_Create_GENRES = "create table if not exists GENRES (ID integer primary key autoincrement, GenreName text)"
                
                
                if !(contactDB?.executeStatements(sql_Create_SONGS))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_DetailPlayList))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_PlayList))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_ALBUMS))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_DetailAlbum))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_ARTISTS))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                if !(contactDB?.executeStatements(sql_Create_GENRES))! {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
                //                let sql_stmt2 = "create table if not exists track (trackid integer primary key autoincrement, trackname text, artistid integer, foreign key (artistid) references artist(artistid))"
                
                if !(contactDB?.executeStatements("PRAGMA foreign_keys = ON"))!
                {
                    print("Error: \(contactDB?.lastErrorMessage())")
                }
            } else {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            contactDB?.close()
            return true
        }
        return false
    }
    func insertDatabase(_ nameTable: String, dict: NSDictionary)
    {
        //Insert
        var keys = String();
        var values = String();
        var first = true
        for key in dict.allKeys
        {
            if (first == true)
            {
                keys = "'" + (key as! String) + "'"
                values = "'" + (dict.object(forKey: key) as! String) + "'"
                first = false
                continue
            }
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (dict.object(forKey: key) as! String) + "'"
        }
        let contactDB = FMDatabase(path: databasePath as String)
        if (contactDB?.open())! {
            if !(contactDB?.executeStatements("PRAGMA foreign_keys = ON"))!
            {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
            let insertSQL = "INSERT INTO \(nameTable) (\(keys)) VALUES (\(values))"
            let result = contactDB?.executeUpdate(insertSQL,
                                                 withArgumentsIn: nil)
            if !result! {
                print("Error: \(contactDB?.lastErrorMessage())")
            }
        }
        contactDB?.close()
    }
    func viewDatabase(_ table: String, columns: [String], statement: String) -> [NSDictionary]
    {
        
        var allColumns = ""
        var items = [NSDictionary]()
        for column in columns
        {
            if (allColumns == "")
            {
                allColumns = column
            }
            else
            {
                allColumns = allColumns + "," + column
            }
        }
        let querySQL = "Select DISTINCT \(allColumns) From \(table) \(statement)"
        let contactDB = FMDatabase(path: databasePath as String)
        if (contactDB?.open())! {
            let results:FMResultSet? = contactDB?.executeQuery(querySQL,
                                                              withArgumentsIn: nil)
            while ((results?.next()) == true)
            {
                items.append(results!.resultDictionary() as NSDictionary)
            }
        }
        contactDB?.close()
        return items
    }
}

