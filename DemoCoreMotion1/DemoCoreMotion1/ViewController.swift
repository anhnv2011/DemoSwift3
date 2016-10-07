//
//  ViewController.swift
//  DemoCoreMotion1
//
//  Created by Tuuu on 8/6/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit
import CoreMotion
class ViewController: UIViewController{
    
    //Instance Variables
    
    var currentMaxAccelX: Double = 0.0
    var currentMaxAccelY: Double = 0.0
    var currentMaxAccelZ: Double = 0.0
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    @IBOutlet weak var img_View: UIImageView!
    var movementManager = CMMotionManager()
    
    //Outlets
    
    
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!
    
    @IBOutlet var accX: UILabel!
    @IBOutlet var accY: UILabel!
    @IBOutlet var accZ: UILabel!
    
    @IBOutlet var maxAccX: UILabel!
    @IBOutlet var maxAccY: UILabel!
    @IBOutlet var maxAccZ: UILabel!
    
    @IBOutlet var rotX: UILabel!
    @IBOutlet var rotY: UILabel!
    @IBOutlet var rotZ: UILabel!
    
    @IBOutlet var maxRotX: UILabel!
    @IBOutlet var maxRotY: UILabel!
    @IBOutlet var maxRotZ: UILabel!
    
    
    @IBAction func resetMaxValues(_ sender: AnyObject) {
        
        
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
    }
    func degree(_ x: Double) -> Double
    {
        return (180*Double(x))/Double(M_PI)
    }
    override func viewDidLoad() {
        currentMaxAccelX = 0
        currentMaxAccelY = 0
        currentMaxAccelZ = 0
        
        currentMaxRotX = 0
        currentMaxRotY = 0
        currentMaxRotZ = 0
        
        movementManager.gyroUpdateInterval = 0.2
        movementManager.accelerometerUpdateInterval = 0.2
        movementManager.deviceMotionUpdateInterval = 0.2
        //Start Recording Data
        movementManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
            self.outputRawValue((data?.attitude)!)
        }
        
        
        movementManager.startAccelerometerUpdates(to: OperationQueue.current!) { (accelerometerData: CMAccelerometerData?, NSError) -> Void in
            let angle = atan2((accelerometerData!.acceleration.x), (accelerometerData!.acceleration.y))
            
            self.img_View.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            self.outputAccData(accelerometerData!.acceleration)
            if(NSError != nil) {
                print("\(NSError)")
            }
        }
        
        movementManager.startGyroUpdates(to: OperationQueue.current!, withHandler: { (gyroData: CMGyroData?, NSError) -> Void in
            self.outputRotData(gyroData!.rotationRate)
            if (NSError != nil){
                print("\(NSError)")
            }
        })
        
    }
    
    func outputRawValue(_ attitude:CMAttitude)
    {
        self.pitchLabel.text = String(self.degree(attitude.pitch))
        self.rollLabel.text  = String(self.degree(attitude.roll))
        self.yawLabel.text  = String(self.degree(attitude.yaw))
    }
    func outputAccData(_ acceleration: CMAcceleration)
    {
        
        accX?.text = "\(acceleration.x).2fg"
        if fabs(acceleration.x) > fabs(currentMaxAccelX)
        {
            currentMaxAccelX = acceleration.x
        }
        
        accY?.text = "\(acceleration.y).2fg"
        if fabs(acceleration.y) > fabs(currentMaxAccelY)
        {
            currentMaxAccelY = acceleration.y
        }
        
        accZ?.text = "\(acceleration.z).2fg"
        if fabs(acceleration.z) > fabs(currentMaxAccelZ)
        {
            currentMaxAccelZ = acceleration.z
        }
        maxAccX?.text = "\(currentMaxAccelX).2f"
        maxAccY?.text = "\(currentMaxAccelY).2f"
        maxAccZ?.text = "\(currentMaxAccelZ).2f"
        
        
    }
    
    func outputRotData(_ rotation: CMRotationRate)
    {
        rotX?.text = "\(rotation.x).2fr/s"
        if fabs(rotation.x) > fabs(currentMaxRotX)
        {
            currentMaxRotX = rotation.x
        }
        
        rotY?.text = "\(rotation.y).2fr/s"
        if fabs(rotation.y) > fabs(currentMaxRotY)
        {
            currentMaxRotY = rotation.y
        }
        
        rotZ?.text = "\(rotation.z).2fr/s"
        if fabs(rotation.z) > fabs(currentMaxRotZ)
        {
            currentMaxRotZ = rotation.z
        }
        maxRotX?.text = "\(currentMaxRotX).2f"
        maxRotY?.text = "\(currentMaxRotY).2f"
        maxRotZ?.text = "\(currentMaxRotZ).2f"
    }
    
}

