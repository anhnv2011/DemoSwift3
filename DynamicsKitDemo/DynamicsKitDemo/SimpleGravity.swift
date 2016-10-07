//
//  SimpleGravity.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/15/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class SimpleGravity: UIViewController {
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    let boxSize: CGFloat = 30
    let box = UIView()
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge()
        
        configureDynamicKit()
        
        box.frame = CGRect(x: 150, y: 0, width: boxSize, height: boxSize)
        box.backgroundColor = UIColor.black
        self.view.addSubview(box)
        
        //Trễ 1 giây rồi mới chạy.
        //Câu hỏi: khác gì với NSThread.sleep() ?
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),execute: {
            self.addBoxToPhysic()
        })
    }
    
    func configureDynamicKit() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 0.8) //Thử đổi giá trị x, y của vector xem kết quả thế nào
        animator!.addBehavior(gravity)
        
        collider.translatesReferenceBoundsIntoBoundary = true  //Chuyển reference thành khung để giới hạn chuyển động
        animator!.addBehavior(collider)
    }
    
    func addBoxToPhysic() {
        collider.addItem(box)  //Không có lệnh này, box không va chạm
        
        gravity.addItem(box) //Không có lệnh này, box không rơi
    }
}
