//
//  AppDelegate.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/8/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        initDataBase()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 251/255, green: 125/255, blue: 4/255, alpha: 1.0)], for: .selected)
        return true
    }
    func initDataBase()
    {
        let database = DataBase.sharedInstance
        if (database.createDatabase() == false)
        {
            return
        }
        //ALBUMS
        
        database.insertDatabase("ALBUMS", dict: ["Price":"200.000", "AlbumName":"Anh Bỏ Thuốc Em Sẽ Yêu", "ReleaseDate":"11/1/2015", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu - Lyna Thùy Linh.jpg"])
        database.insertDatabase("ALBUMS", dict: ["Price":"350.000", "AlbumName":"Anh Cứ Đi Đi", "ReleaseDate":"3/4/2015", "UrlImg":"Anh Cứ Đi Đi.jpg"])
        database.insertDatabase("ALBUMS", dict: ["Price":"400.000", "AlbumName":"Bí Mật Bị Thời Gian Vùi Lấp", "ReleaseDate":"6/9/2015", "UrlImg":"Bí Mật Bị Thời Gian Vùi Lấp.jpg"])
        database.insertDatabase("ALBUMS", dict: ["Price":"700.000", "AlbumName":"Đếm Ngày Xa Em - Lou Hoàng,OnlyC", "ReleaseDate":"30/1/2014", "UrlImg":"Đếm Ngày Xa Em - Lou Hoàng,OnlyC.jpg"])
        database.insertDatabase("ALBUMS", dict: ["Price":"150.000", "AlbumName":"Yêu Một Người Không Sai", "ReleaseDate":"19/5/2016", "UrlImg":"Yêu Một Người Không Sai.jpg"])
        
        //ARTISTS
        database.insertDatabase("ARTISTS", dict: ["ArtistName":"Chí Thiện", "Born":"19/5/1986", "UrlImg":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST).jpg"])
        database.insertDatabase("ARTISTS", dict: ["ArtistName":"HariWon", "Born":"20/11/1983", "UrlImg":"Anh Cứ Đi Đi - Hari Won.jpg"])
        database.insertDatabase("ARTISTS", dict: ["ArtistName":"LOU HOÀNG", "Born":"19/1/1990", "UrlImg":"LOUHOANG.jpg"])
        database.insertDatabase("ARTISTS", dict: ["ArtistName":"LYNA THUỲ LINH", "Born":"27/8/1992", "UrlImg":"LYNA THÙY LINH.jpg"])
        database.insertDatabase("ARTISTS", dict: ["ArtistName":"MAI FIN", "Born":"19/5/1993", "UrlImg":"Chủ Nhật Buồn .jpg"])
        //Genres
        database.insertDatabase("GENRES", dict: ["GenreName":"Nhạc Trẻ"])
        database.insertDatabase("GENRES", dict: ["GenreName":"Trữ Tình"])
        
        //PlayList
        database.insertDatabase("PLAYLIST", dict: ["PlaylistName":"Nhạc Nghe Lúc Buồn"])
        database.insertDatabase("PLAYLIST", dict: ["PlaylistName":"Nhạc Thất Tình"])
        
        //Song
        database.insertDatabase("SONGS", dict: ["SongName":"Anh Bỏ Thuốc Em Sẽ Yêu", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Gái Nhà Lành", "UrlImg":"Gái Nhà Lành.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Anh Cứ Đi Đi", "UrlImg":"Anh Cứ Đi Đi - Hari Won.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Điệp Khúc Mùa Xuân - Sơn Ngọc Minh, Hari Won", "UrlImg":"Điệp Khúc Mùa Xuân.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Chỉ Mong Trái Tim Người", "UrlImg":"Chỉ Mong Trái Tim Người.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST)", "UrlImg":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST).jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Đếm Ngày Xa Em", "UrlImg":"Đếm Ngày Xa Em.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Yêu Một Người Có Lẽ", "UrlImg":"Yêu Một Người Có Lẽ.jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Chủ Nhật Buồn", "UrlImg":"Chủ Nhật Buồn .jpg"])
        database.insertDatabase("SONGS", dict: ["SongName":"Yêu Một Người Không Sai", "UrlImg":"Yêu Một Người Không Sai.jpg"])
        
        //DetailPlaylist
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"1", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"2", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"3", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"4", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"5", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"6", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"7", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"8", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"9", "PlayListID":"1"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"10", "PlayListID":"1"])
        
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"6", "PlayListID":"2"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"7", "PlayListID":"2"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"8", "PlayListID":"2"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"9", "PlayListID":"2"])
        database.insertDatabase("DETAILPLAYLIST", dict: ["SongID":"10", "PlayListID":"2"])
        
        //DetailAlbum
        
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"1", "GenreID":"1", "ArtistID":"4", "SongID":"1"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"1", "GenreID":"1", "ArtistID":"4", "SongID":"2"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"2", "GenreID":"1", "ArtistID":"2", "SongID":"3"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"2", "GenreID":"1", "ArtistID":"2", "SongID":"4"])
        
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"3", "GenreID":"1", "ArtistID":"5", "SongID":"5"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"3", "GenreID":"1", "ArtistID":"5", "SongID":"6"])
        
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"4", "GenreID":"1", "ArtistID":"3", "SongID":"7"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"4", "GenreID":"1", "ArtistID":"3", "SongID":"8"])
        
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"5", "GenreID":"1", "ArtistID":"1", "SongID":"9"])
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"5", "GenreID":"1", "ArtistID":"1", "SongID":"10"])
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

