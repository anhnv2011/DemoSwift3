//
//  ViewController.swift
//  Calculator
//
//  Created by Vinh The on 7/4/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    // MARK: Views
    @IBOutlet weak var DisplayView: UIView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var calculatorView: UIView!
    // MARK: Constraints
    @IBOutlet weak var distanceBetweenResultAndInputTextField: NSLayoutConstraint!
    
    @IBOutlet weak var distanceBetweenResultAndMiddleView: NSLayoutConstraint!
    
    // MARK: Objects
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    // MARK: Variables
    var isTappingNumber : Bool = false
    var isEndOperation : Bool = true
    var firstNumber : Double = 0
    var secondNumber : Double = 0
    var operation = ""
    
    var audioPlayer = AVAudioPlayer()
    var soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: "click2", ofType: ".wav")!)
    
    // MARK: Configure UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        playSound()
    }
    
    func playSound() -> Void {
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        }catch{
            print("Error")
        }
        
        audioPlayer.prepareToPlay()
    }
    
    func configureViews() -> Void {
//        calculatorView.backgroundColor = UIColor.init(red: 49/255, green: 58/255, blue: 75/255, alpha: 1.0)
        
        middleView.backgroundColor = UIColor.clear
        
        inputTextField.isUserInteractionEnabled = false
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        updateConstraint()
        
    }
    
    func updateConstraint() -> Void {
        let scale = (UIScreen.main.bounds.size.height / 667)
        
        print("Scale : \(scale)")
        print("Before : \(distanceBetweenResultAndInputTextField.constant)")
        
        distanceBetweenResultAndMiddleView.constant = UIScreen.main.bounds.size.height > 480 ? distanceBetweenResultAndMiddleView.constant * scale :
            distanceBetweenResultAndMiddleView.constant * 0.1
        
        distanceBetweenResultAndInputTextField.constant = UIScreen.main.bounds.size.height > 480 ? distanceBetweenResultAndInputTextField.constant * scale :
            distanceBetweenResultAndInputTextField.constant * 0.1
        
        print("After : \(distanceBetweenResultAndInputTextField.constant * scale)")
    }
    
    
    // MARK: Actions
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        print(isTappingNumber)
        
        let number = sender.currentTitle
        
        if isTappingNumber {
            inputTextField.text = inputTextField.text! + number!
        }else{
            inputTextField.text = number
            isTappingNumber = true
        }
        
        audioPlayer.play()
    }
    
    
    @IBAction func operatorsAction(_ sender: UIButton) {
        
        operation = sender.currentTitle!
        
        if let inputOperation = Double(inputTextField.text!) {
            
            if isEndOperation == false {
                
                firstNumber = Double(resultLabel.text!)!
                
                inputTextField.text = "\(firstNumber)"
                
            }else{
                
                firstNumber = inputOperation
                
                isEndOperation = false
            }
            
        }else{
            
            print("You need input your number before doing operation")
            
        }
        
        isTappingNumber = false
        
        if operation == "%" {
            
            equalsAction(sender)
            
        }else if operation == "+/-"{
            
            equalsAction(sender)
            
        }
        
        audioPlayer.play()
        
    }
    
    
    @IBAction func equalsAction(_ sender: UIButton) {
        
        isTappingNumber = false
        
        var result : Double = 0
        
        if let realSecondNumber = Double(inputTextField.text!) {
            
            secondNumber = realSecondNumber
            
        }
        switch operation {
        case "+":
            result = firstNumber + secondNumber
        case "-":
            result = firstNumber - secondNumber
        case "*":
            result = firstNumber * secondNumber
        case "/":
            result = firstNumber / secondNumber
        case "%":
            result = firstNumber / 100
        case "+/-":
            if firstNumber < 0 {
                firstNumber = fabs(firstNumber)
                result = firstNumber
            }else{
                firstNumber = -1 * firstNumber
                result = firstNumber
            }
            inputTextField.text = "\(result)"
        default:
            print("Error Operation")
        }
        
        resultLabel.text = "\(result)"
        
        audioPlayer.play()
    }
    
    @IBAction func ACAction(_ sender: AnyObject) {
        firstNumber = 0
        secondNumber = 0
        inputTextField.text = ""
        resultLabel.text = "0"
        isEndOperation = true
        
        audioPlayer.play()
    }
    
}

