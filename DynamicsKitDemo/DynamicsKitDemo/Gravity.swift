//
//  ViewController.swift
//  DynamicsKitDemo
//
//  Created by Trung on 8/2/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class Gravity: UIViewController {
    
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
    let boxSize: CGFloat = 30
    
    var boxers:Array<UIView> = []
 
    
    var animator: UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
        animator?.addBehavior(gravity)

        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
    }
    
    func addBoxToBehaviors(_ box:UIView){
        gravity.addItem(box)
        collider.addItem(box)
    }
    
    
    func addBox(_ location: CGRect, color: UIColor) ->UIView {
        let newBox = UIView(frame: location)
        newBox.backgroundColor = color
        view.addSubview(newBox)
        
        addBoxToBehaviors(newBox)
        // this is a new in beta 5, The += operator on arrays only concatenates arrays, it does not append an element. This resolves ambiguity working with Any, AnyObject and related types.
        // So if you want to append  new element in to array 
        // boxers.append(newItem) or below
        boxers += [newBox]
    
        return newBox
    }
    
    func checkValidateRect (_ testRect: CGRect) ->Bool {
        
        for box:UIView in boxers {
            let rect = box.frame
            if (testRect.intersects(rect)){
                return false
            }
        }
        return true
    }
    
    func randomFrame()->CGRect {
        var guessRect = CGRect(x: 9, y: 9, width: boxSize, height: boxSize)
        while(!checkValidateRect(guessRect)) {
            let guessX = CGFloat(UInt(arc4random())).truncatingRemainder(dividingBy: maxX)
            let guessY = CGFloat(UInt(arc4random())).truncatingRemainder(dividingBy: maxY)
           
            guessRect = CGRect(x: guessX, y: guessY, width: boxSize, height: boxSize)
        }
        return guessRect
    }
    
    func generateBoxes() {
        for i in 0...6 {
            let frame = randomFrame()
            let color = randomColor()
            var newBox = addBox(frame, color: color)
        }
    }
    
    func randomColor()->UIColor {
       
        let red = CGFloat(Float(arc4random_uniform(256)) / 255.0)
        let green = CGFloat(Float(arc4random_uniform(256)) / 255.0)
        let blue = CGFloat(Float(arc4random_uniform(256)) / 255.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        maxX = super.view.bounds.size.width - boxSize;
        maxY = super.view.bounds.size.height - boxSize;
        createAnimatorStuff()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC),execute: {
             self.generateBoxes()
        })
       
    }

}

