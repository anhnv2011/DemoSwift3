//
//  UIViewControllerBase.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class UIViewControllerBase: UIViewController{
    
    @IBOutlet weak var txt_Search: UITextField!
    @IBOutlet weak var btn_Title: UIButton!
    var labels = [Label]()
    var listView = ListView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), style: .plain)
    let dataBase = DataBase.sharedInstance
    var items = [NSDictionary]()
    var type = Type.songs
    var nameArtists = [String]()
    var currentIndexOption = 1
    //#MARK: Override view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge()
        hiddenListViewAndSearch()
        txt_Search.placeholder = "Enter name here"
        self.btn_Title.backgroundColor = UIColor(colorLiteralRed: 39/255, green: 42/277, blue: 49/277, alpha: 1.0)
        self.view.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/277, blue: 34/277, alpha: 1.0)
        let textAttribute = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:UIFont(name: "Helvetica", size: 26)!]
        btn_Title.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
        self.tabBarController!.navigationItem.title = "My Music"
        self.navigationController?.navigationBar.titleTextAttributes = textAttribute
        self.view.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (listView.frame.origin.x == 0)
        {
            addListOptions()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenListViewAndSearch()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setActionForRightBarButton()
        selectFirstItem()
        setupListView()
        hiddenListViewAndSearch()
    }
    func setupListView()
    {
        listView.items = labels
        listView.type = Type.playlist
        loadTitle(currentIndexOption)
    }
    //#MARK: Process Interface
    func setStateForListView()
    {
        listView.isHidden = !listView.isHidden
    }

    func loadTitle(_ index: Int)
    {
        btn_Title.setTitle(getTitleWithID(index), for: UIControlState())
        self.tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = true
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
    func addListOptions()
    {
        listView = ListView(frame: CGRect(x: btn_Title.center.x - 100, y: btn_Title.frame.origin.y + btn_Title.frame.size.height, width: 200, height: 100), style: .plain)
//        listView.delegateSelectItem = self
        self.view.addSubview(listView)
    }
    func setActionForRightBarButton()
    {
        self.tabBarController!.navigationItem.rightBarButtonItem?.target = self
        self.tabBarController!.navigationItem.rightBarButtonItem?.action = #selector(checkHiddenSearch)
    }
    func checkHiddenSearch()
    {
        swapStateSearchWithLabel(true)
        if txt_Search.isHidden == true {
            UIView.transition(with: self.txt_Search, duration: 0.5, options: UIViewAnimationOptions.transitionCurlDown, animations: nil, completion: nil)
            self.txt_Search.becomeFirstResponder() //Show keyboard
            self.txt_Search.isHidden = false
        } else {
            UIView.transition(with: self.txt_Search, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
            self.txt_Search.resignFirstResponder() // End edit text
            self.txt_Search.isHidden = true
        }
    }
    func swapStateSearchWithLabel(_ isSearch: Bool)
    {
        if (isSearch == true)
        {
            btn_Title.isEnabled = !txt_Search.isHidden
            
        }
        else
        {
            self.tabBarController!.navigationItem.rightBarButtonItem!.isEnabled = !self.tabBarController!.navigationItem.rightBarButtonItem!.isEnabled
        }
    }
    func hiddenListViewAndSearch()
    {
        listView.isHidden = true
        txt_Search.isHidden = true
    }
    func selectFirstItem()
    {
        let indexPath = IndexPath(row: currentIndexOption-1, section: 0)
        listView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
//        listView.tableView(listView, didSelectRowAtIndexPath: indexPath)
    }
    //# MARK: Action
    
    @IBAction func action_Label(_ sender: UIButton)
    {
        listView.isHidden = !listView.isHidden
        swapStateSearchWithLabel(false)
    }
    
}
