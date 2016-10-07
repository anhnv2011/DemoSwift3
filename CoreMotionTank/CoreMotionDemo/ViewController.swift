//
//  ViewController.swift
//  CoreMotionDemo
//
//  Created by Tuuu on 7/30/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let movementManager = CMMotionManager()
    let tank = Tank(frame: CGRectMake(100, 100, 50, 30))
    var isStart = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tank)
        movementManager.accelerometerUpdateInterval = 0.2
        startAccelerometer()
    }
    func startAccelerometer()
    {
        movementManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            let angle = atan2((accelerometerData!.acceleration.x), (accelerometerData!.acceleration.y))
            self.tank.radian = angle
            self.tank.transform = CGAffineTransformMakeRotation(CGFloat(angle + oneHundredEightyDegree))
            self.tank.updateMove()
        }
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            if (isStart)
            {
                movementManager.stopAccelerometerUpdates()
                isStart = false
            }
            else
            {
                startAccelerometer()
                isStart = true
            }
        }
    }
    
}

