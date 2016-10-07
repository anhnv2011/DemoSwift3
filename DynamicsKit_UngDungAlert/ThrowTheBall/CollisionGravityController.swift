//
//  CollisionGravityController.swift
//  ThrowTheBall
//
//  Created by Tuuu on 8/11/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class CollisionGravity: UIViewController, UICollisionBehaviorDelegate
{
    var ball = UIImageView()
    var animator = UIDynamicAnimator()
    var attachmentBehavior:UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    var pushBehavior: UIPushBehavior!
    @IBOutlet weak var brickV4: UIView!
    @IBOutlet weak var brickV3: UIView!
    @IBOutlet weak var brickV2: UIView!
    @IBOutlet weak var brickV1: UIView!
    
    //UIAttachmentBehavior
    //UIPushBehavior
    //UIDynamicItemBehavior
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ball = UIImageView(frame: CGRect(x: 100, y: 200, width: 40, height: 40))
        self.ball.image = UIImage(named: "ball.png")
        self.view.addSubview(self.ball)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.view.addGestureRecognizer(panGesture)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePush(_:)))
//        self.view.addGestureRecognizer(tapGesture)
        
//        panGesture.requireGestureRecognizerToFail(tapGesture)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        let gravityBehavior = UIGravityBehavior(items: [self.ball])
        //Độ rơi nhanh
//        gravityBehavior.magnitude = 1
        //Góc bay sau khi chạm biên thì nó sẽ bay về góc thuộc section đó
//        gravityBehavior.angle = 2.0472
        
//        gravityBehavior.gravityDirection = CGVectorMake(0, 1)
        animator.addBehavior(gravityBehavior)
        
        
        let collisionBehavior = UICollisionBehavior(items: [self.ball])
        collisionBehavior.addItem(self.brickV1)
        collisionBehavior.addItem(self.brickV2)
        collisionBehavior.addItem(self.brickV3)
        collisionBehavior.addItem(self.brickV4)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
//        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        
        
        
        
        attachmentBehavior = UIAttachmentBehavior(item: self.ball, attachedToAnchor: CGPoint(x: self.ball.center.x, y: self.ball.center.y))
        //Tần số giao động
        attachmentBehavior.frequency = 100
        //Độ dãn
        attachmentBehavior.damping = 1
        //Cách tâm
        attachmentBehavior.length = 50

        animator.addBehavior(attachmentBehavior)
        
        
        
        //Push
        self.pushBehavior = UIPushBehavior(items: [self.ball], mode: .continuous)
//        self.animator.addBehavior(self.pushBehavior)
        
        
        
        //UIDynamicItemBehavior
        let ballProterty = UIDynamicItemBehavior(items: [self.ball])
//        ballProterty.elasticity = 1
//        ballProterty.allowsRotation = false
//        ballProterty.angularResistance = 100  ??
//        ballProterty.resistance = 1  ?? Tăng lực chống lại khi quay
//        ballProterty.friction = 1000 //Lực ma sát

        self.animator.addBehavior(ballProterty)

    }
    
    func handlePush(_ gesture: UIPanGestureRecognizer)
    {
        let p = gesture.location(in: self.view)
        let o = self.ball.center
        let distance = sqrtf(powf(Float(p.x) - Float(o.x), 2.0) + powf(Float(p.y) - Float(o.y), 2.0))
        let angle = atan2(p.y - o.y, p.x - o.x)
        pushBehavior.magnitude = CGFloat(distance/100.0)
        pushBehavior.angle = angle
    }
    func handlePan(_ gesture: UIPanGestureRecognizer)
    {
        attachmentBehavior.anchorPoint = gesture.location(in: self.view)
    }
    //    func handleTap(gesture: UITapGestureRecognizer)
    //    {
    //        removeAllSnapBehavior()
    //        let point = gesture.locationInView(self.view)
    //        let snapBehavior1 = UISnapBehavior(item: self.brickV1, snapToPoint: CGPointMake(point.x, point.y - self.brickV2.frame.height/2))
    //        let snapBehavior2 = UISnapBehavior(item: self.brickV2, snapToPoint: CGPointMake(point.x - self.brickV1.frame.width/2, point.y))
    //        let snapBehavior3 = UISnapBehavior(item: self.brickV3, snapToPoint: CGPointMake(point.x + self.brickV1.frame.width/2, point.y))
    //        let snapBehavior4 = UISnapBehavior(item: self.brickV4, snapToPoint: CGPointMake(point.x, point.y + self.brickV2.frame.height/2))
    //        self.animator.addBehavior(snapBehavior1)
    //        self.animator.addBehavior(snapBehavior2)
    //        self.animator.addBehavior(snapBehavior3)
    //        self.animator.addBehavior(snapBehavior4)
    //
    //
    //    }
    func removeAllSnapBehavior()
    {
        for snap in self.animator.behaviors {
            if(snap.isKind(of: UISnapBehavior.self))
            {
                self.animator.removeBehavior(snap)
            }
        }
    }
}
