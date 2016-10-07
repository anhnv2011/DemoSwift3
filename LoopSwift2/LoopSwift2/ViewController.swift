//
//  ViewController.swift
//  LoopSwift2
//
//  Created by DangCan on 5/14/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var thanhvien = ["ong", "ba", "bo", "me"]
    var n = 5;
    var _margin: CGFloat = 40
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRowOfBall()
       
    }
    func drawRowOfBall(){
        for indexHang in 0..<n {
            for indexCot in 0..<n {
                print(index)
                let image = UIImage(named: "green")
                let ball = UIImageView(image: image)
                ball.center = CGPoint(x: _margin + CGFloat(indexHang) * spaceBetweenBall(), y: CGFloat(indexCot)*50 + _margin)
                
                self.view.addSubview(ball)
            }
            
        }
    }
    func spaceBetweenBall() -> CGFloat {
        let space = (self.view.bounds.size.width - 2*_margin)/CGFloat(n-1)
        return space
    }


}

