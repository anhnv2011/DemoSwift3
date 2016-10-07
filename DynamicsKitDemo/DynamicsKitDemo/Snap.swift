//
//  Snap.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/17/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class Snap: UIViewController {

    @IBOutlet weak var square: UIImageView!
    var animator:UIDynamicAnimator!
    var snapBehavior:UISnapBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(Snap.handleSnapGesture(_:)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(gesture)
        
    }
    
    
    func handleSnapGesture(_ sender:UITapGestureRecognizer){
        let point = sender.location(in: self.view)
        // Remove the previous behavior
        if (self.snapBehavior != nil)
        {
            self.animator.removeBehavior(self.snapBehavior)
        }
        let newSnapBehavior = UISnapBehavior(item: self.square, snapTo: point)
        newSnapBehavior.damping = 0.1
        self.animator.addBehavior(newSnapBehavior)
        self.snapBehavior = newSnapBehavior
        
    }

}
