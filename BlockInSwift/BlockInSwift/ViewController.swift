//
//  ViewController.swift
//  BlockInSwift
//
//  Created by anhnguyenviet on 6/1/16.
//  Copyright © 2016 anhnguyenviet. All rights reserved.
//
//Change
import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var img_Profile: UIImageView!
    var imgs = ["https://i.ytimg.com/vi/yIZlTHgfFYw/maxresdefault.jpg", "http://news.xinhuanet.com/fashion/2012-12/19/124106746_131n.jpg",
                "https://s-media-cache-ak0.pinimg.com/736x/3f/a1/62/3fa162dbd33effa671b5e5a820952c88.jpg", "http://top10for.com/wp-content/uploads/2015/02/Hottest-Victoria%E2%80%99s-Secret-Models1.jpg"]
    
    var block:(() -> ())?
    let noP = {() -> () in
        print("1")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        noP()
    }
    @IBAction func a_print(_ sender: AnyObject)
    {
        makeSound(1, block: { (value) in
        })
    }
    func makeSound(_ x: Int, block: (_ value: String) -> ())
    {
        print("123")
    }
    func loadData(_ complete:@escaping (_ data: Data, _ index: Int)->())
    {
        DispatchQueue.global().async(execute: {
            for stringUrl in self.imgs
            {
                if let url = URL(string: stringUrl)
                {
                    if let data = try? Data(contentsOf: url) {
                        complete(data, self.imgs.index(of: stringUrl)!)
                    }
                }
            }
        })
    }
    @IBAction func play(_ sender: AnyObject)
    {
        loadData({ (data, index) in
            DispatchQueue.main.async(execute: {
                if let imgView = self.view.viewWithTag(100+index) as? UIImageView
                {
                    imgView.image = UIImage(data: data)
                }
            })
        })
        
    }
}

