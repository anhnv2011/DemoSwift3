//
//  ViewController.swift
//  NSOperationSwift
//
//  Created by Tuuu on 6/17/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let opQ = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func actionCancel(_ sender: UIButton)
    {
        opQ.cancelAllOperations()
    }
    @IBAction func actionOp(_ sender: UIButton)
    {

        
        opQ.maxConcurrentOperationCount = 1
        let opBlock = BlockOperation()
        opBlock.addExecutionBlock {
            for _ in 0...100000
            {
                print("opB1")
            }
        }
        opBlock.completionBlock = {
            print("Done1")
        }
        
        
        let opBlock2 = BlockOperation()
        opBlock2.addExecutionBlock {
            for _ in 0...100
            {
                print("opB2")
            }
        }
        opBlock2.completionBlock = {
            print("Done2")
        }
        
        
        let opBlock3 = BlockOperation()
        opBlock3.addExecutionBlock {
            for _ in 0...100
            {
                print("opB3")
            }
        }
        opBlock3.completionBlock = {
            print("Done3")
        }
        
        
        
        let opBlock4 = BlockOperation()
        opBlock4.addExecutionBlock {
            for _ in 0...100
            {
                print("opB4")
            }
        }
        opBlock4.completionBlock = {
            print("Done4")
        }
        
        let opBlock5 = BlockOperation()
        opBlock5.addExecutionBlock {
            for _ in 0...100
            {
                print("opB5")
            }
        }
        opBlock5.completionBlock = {
            print("Done5")
        }
        
        opBlock.queuePriority = .veryLow
        opBlock2.queuePriority = .veryLow
        opBlock3.queuePriority = .veryLow
        opBlock4.queuePriority = .veryHigh
        opBlock5.queuePriority = .veryLow
        opBlock5.addDependency(opBlock4)
        
//        opBlock5.dependencies
        let opp = Operation(name: "Nguyen Van Tu")
        
        opQ.addOperation(opp)
        opQ.addOperation(opBlock)
        opQ.addOperation(opBlock2)
        opQ.addOperation(opBlock3)
        opQ.addOperation(opBlock4)
        opQ.addOperation(opBlock5)
    }
}
class Operation: Foundation.Operation
{
    var nameOp: String
    init(name: String) {
        nameOp = name
        super.init()
    }
    override func main() {
        for _ in 0...1000
        {
            print("op \(nameOp)")
        }
    }
}

