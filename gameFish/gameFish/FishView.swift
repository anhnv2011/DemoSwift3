//
//  FishView.swift
//  gameFish
//
//  Created by CanDang on 12/24/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    var status : Int?
    var speed : Int?
    var vy : Int?
    var widthFrame : Int?
    var heightFrame : Int?
    var widthFish : Int?
    var heightFish : Int?
    let MOVING : Int = 0
    let CAUGHT : Int = 1
//    required init(coder aDecoder: NSCoder)
//    {
//        super.init(coder: aDecoder)!
//        
//        // Your intializations
//    }
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
        // custom code
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func generateFish(_ width:Int)
    {
        self.widthFrame = width;
        self.vy = Int(arc4random_uniform(3)) - 1
        let y : Float = Float(arc4random_uniform(240)) + 80
        self.status = MOVING
        self.speed = (Int)(arc4random_uniform(5)) + 2
        
        if (Int(self.center.x) <=  -Int(self.widthFish!/2))
        {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: "fishroll")
            self.frame = CGRect(x: -CGFloat(self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
        }
        else
        {
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: UIImage(named:"fishroll")!.cgImage!, scale: 1.0, orientation:UIImageOrientation.upMirrored)
            self.frame = CGRect(x: CGFloat(self.widthFrame!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            self.speed = -Int(self.speed!)
        }
    }
    func updateMove()
    {
        if (self.status == MOVING)
        {
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            if (Int(self.center.y) < -Int(self.heightFish!) || Int(self.center.y) > self.heightFish! + 300)
            {
                self.vy = -self.vy!
            }
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0) || (Int(self.center.x) < -self.widthFish! && self.speed! < 0))
            {
                generateFish(self.widthFrame!)
            }
        }
        else if (self.status == CAUGHT)
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            if (Int(self.frame.origin.y) <= -Int(self.widthFish!) )
            {
                generateFish(self.widthFrame!)
            }
        }
    }
    func caught()
    {
        if (self.status == MOVING)
        {
            self.status = CAUGHT
            if (self.speed! > 0)
            {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
            }
            else
            {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            }
        }
    }
    
}
