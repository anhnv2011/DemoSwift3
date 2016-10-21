//
//  AdoptProtocol.swift
//  DemoSwift3
//
//  Created by Techmaster on 10/6/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit
protocol Drawable {
    func draw()
}

class AdoptProtocol: ConsoleScreen {

    
    struct Point: Drawable {
        var x, y: Double
        func draw() {
            print("Point draw")
        }
    }
    
    struct Line: Drawable {
        var x1, y1, x2, y2: Double
        func draw() {
            print("Line draw")
        }
    }
    
    struct LineCool : Drawable {
        var begin, end: Point
        func draw() {
            print("LineCool draw")
        }
    }
    class Diem: Drawable {
        var x: Double
        var y: Double
        init(x: Double, y: Double) {
            self.x = x
            self.y = y
        }
        func draw() {
            print("Diem draw")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        var drawables = [Drawable]()
        drawables.append(Point(x: 10.0, y: 12.1))
        drawables.append(Line(x1: 0, y1: 1, x2: 2, y2: 3))
        drawables.append(LineCool(begin: Point(x: 0, y: 1), end: Point(x: 1, y:2)))
        drawables.append(Diem(x: 10, y: 20))
        
        drawables.forEach { (drawable) in
            drawable.draw()
        }
        
        
    }


}
