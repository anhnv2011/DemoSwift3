//
//  Tank.swift
//  CoreMotionDemo
//
//  Created by Tuuu on 8/3/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
let oneHundredEightyDegree = 3.14159
let speed:Double = 10
class Tank: UIImageView {
    var radian: Double = 0
    //    var moveY: Double = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "Tank.png")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateMove()
    {
        
        if (radian >= oneHundredEightyDegree/2 && radian <= oneHundredEightyDegree)
        {
            //Tỷ lệ là:100% với chiều theo chiều kim đồng hồ, thì nếu tỷ lệ góc quay là 70% thì với trường hợp lên phải thì xe tăng sẽ di chuyển theo chiều ngang nhiều hơn nên sẽ nhâm với 70% còn trục y sẽ là 30%
            let scale = abs((radian-oneHundredEightyDegree/2)/(oneHundredEightyDegree-oneHundredEightyDegree/2))
            self.center = CGPoint(x: self.center.x + CGFloat(speed*scale), y: self.center.y - CGFloat(speed*(1 - scale)))
            print("Len phai")
        }
        else if (radian > -oneHundredEightyDegree && radian < -oneHundredEightyDegree/2)
        {
            let scale = abs((radian+oneHundredEightyDegree/2)/(oneHundredEightyDegree-oneHundredEightyDegree/2))
            self.center = CGPoint(x: self.center.x + CGFloat(speed*scale), y: self.center.y + CGFloat(speed*(1 - scale)))
            print(scale)
            print("Xuong phai")
        }
        else if (radian >= -oneHundredEightyDegree/2 && radian <= 0)
        {
            let scale = abs((radian)/(oneHundredEightyDegree/2))
            self.center = CGPoint(x: self.center.x - CGFloat(speed*(1 - scale)), y: self.center.y + CGFloat(speed*scale))
            print(scale)
            print("Xuong trai")
        }
        else
        {
            let scale = abs((radian)/(oneHundredEightyDegree/2))
            print("Len trai")
            print(scale)
            
            self.center = CGPoint(x: self.center.x - CGFloat(speed*(1 - scale)), y: self.center.y - CGFloat(speed*scale))
        }
        
    }
    
}