//
//  ViewController.swift
//  QuickPlayer_V
//
//  Created by Chung on 8/23/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var my_Switch: UISwitch!
    var audio = AVAudioPlayer()
    var isPlaying = true
    var timer = Timer()
    
    
    
    @IBOutlet weak var slider_Duration: UISlider!
    @IBOutlet weak var maxDuration: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        audio.prepareToPlay()

        addThumbImgForSlider()
        my_Switch.addTarget(self, action: #selector(switchIsChange), for: UIControlEvents.valueChanged)
        let minu: Int = Int(audio.duration / 60)
        let sec: Int = Int(audio.duration.truncatingRemainder(dividingBy: 60))
        slider_Duration.maximumValue = Float(audio.duration)
    }
    
    

    func updateFrame() {
        let minu: Int = Int(audio.currentTime / 60)
        let sec: Int = Int(audio.currentTime.truncatingRemainder(dividingBy: 60))
        if (sec < 10 && minu < 10){
            self.duration.text = "0\(minu):0\(sec) "
            
        }else{
            if sec < 10 {
                self.duration.text = "\(minu):0\(sec) "
            } else if minu < 10 {
                self.duration.text = "0\(minu):\(sec) "
            }else{
                self.duration.text = "\(minu):\(sec) "
            }
            
        }
        

        slider_Duration.value = Float(audio.currentTime)
        
    }
    func switchIsChange(){

    }
    
    @IBAction func slider_Duration(_ sender: UISlider) {

    
    }
    
    @IBAction func btnPlay(_ sender: UIButton) {
        if isPlaying {
            audio.play()
            btnPlay.setImage(UIImage(named: "pause.png"), for: UIControlState())
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateFrame), userInfo: nil, repeats: true)
            switchIsChange()
            
            
        }else{
            audio.pause()
            btnPlay.setImage(UIImage(named: "play.png"), for: UIControlState())
            timer.invalidate()
        }
        isPlaying = !isPlaying
        
    }
    
    
    @IBAction func slide(_ sender: UISlider) {
        print(sender.value)
        audio.volume = sender.value
    }
    
    func addThumbImgForSlider() {
        slide.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        
        slide.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
        
    }
}

