//
//  DrawHandle.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/18/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class DrawHandle: UIViewController {

    @IBOutlet weak var pointA: UIImageView!
    @IBOutlet weak var pointB: UIImageView!
    var handle: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pointA.tintColor = UIColor.red
        pointB.tintColor = UIColor.blue
        pointA.image = pointA.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pointB.image = pointB.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pointA.isUserInteractionEnabled = true
        pointB.isUserInteractionEnabled = true
        
        pointA.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DrawHandle.onPanPoint(_:))))
        pointB.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(DrawHandle.onPanPoint(_:))))
    }
    
    func onPanPoint (_ sender: UIPanGestureRecognizer) {
        let panPoint = sender.location(in: self.view)
        sender.view?.center = panPoint
    }

}
