//
//  ViewController.swift
//  Weather
//
//  Created by Vinh The on 7/9/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempButton: UIButton!
    
    @IBOutlet weak var CFLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var quote = ["Since we cannot change reality, let us change the eyes which see reality.",
                 "Without a struggle, there can be no progress.",
                 "If you don't like something, change it. If you can't change it, change your attitude."]
    
    var city = ["Courtneyfurt",
                "South Wilford",
                "East Rosendo"]
    
    var images = ["Blood","Moon","Sun"]
    
    var isCel : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func changeTempAction(_ sender: AnyObject) {
        isCel = !isCel
        
        var currentTemp = Double((tempButton.titleLabel?.text)!)
        
        if isCel {
            currentTemp = (currentTemp! - 32) / 1.8
            
            tempButton.setTitle(String(format: "%2.1f", currentTemp!), for: UIControlState())
            
            CFLabel.text = "C"
        }else{
            currentTemp = currentTemp! * 1.8 + 32
            
            tempButton.setTitle(String(format: "%2.1f", currentTemp!), for: UIControlState())
            
            CFLabel.text = "F"
        }
        
       
    }
    
    
    @IBAction func changeCAndF(_ sender: AnyObject) {
        
        let cityIndex = Int(arc4random_uniform(UInt32(city.count)))
        
        cityLabel.text = city[cityIndex]
        
        let quoteIndex = Int(arc4random_uniform(UInt32(quote.count)))
        
        quoteLabel.text = quote[quoteIndex]
        
        let imageIndex = Int(arc4random_uniform(UInt32(images.count)))
        
        backgroundImage.image = UIImage.init(named: images[imageIndex])
        
        getTemp()
        
    }
    
    func getTemp() -> Void {
        
        let temp = String(format: "%2.1f", randomTemp())
        
        tempButton.setTitle(temp, for: UIControlState())
        
    }
    
    func randomTemp() -> Double {
        
        if isCel {
            return Double(arc4random_uniform(18) + 14) + Double(arc4random()) / Double(INT32_MAX)
        }else{
            return (Double(arc4random_uniform(18) + 14) + Double(arc4random()) / Double(INT32_MAX)) * 1.8 + 32
        }
        
    }
    
    

}

