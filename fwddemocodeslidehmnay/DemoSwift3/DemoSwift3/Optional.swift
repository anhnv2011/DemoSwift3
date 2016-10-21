//
//  Optional.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/28/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//  Bài này chúng ta học về 3 toán tử: ? optional, ! unwrap ?? optional default value

import UIKit


class Optional: ConsoleScreen {
    class Car {
        var model: String
        var plateNum: String
        init(model: String, plateNum: String) {
            self.model = model
            self.plateNum = plateNum
        }
        
        func run() {
            print("\(model) - \(plateNum) runs")
        }
    }
    //Có thể định nghĩa class trong class, lúc này có 2 class Person khác phạm vi vẫn có thể cùng tồn tại
    class Person {
        var name: String
        var girlFriendName: String?
        var ownedCar: Car?
        init(name: String) {
            self.name = name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cuong = Person(name: "Cuong")
        writeln("\(cuong.ownedCar)")
        
        //Tồn tại thì chạy, không thì thôi
        cuong.ownedCar?.run()
        
        //Nếu đối tượng nil sẽ gây lỗi
        //cuong.ownedCar!.run()
        
        cuong.ownedCar = Car(model: "Chevrolet Colorado", plateNum: "AZ-125")
        if let car = cuong.ownedCar {
            car.run()
            //car =
        }
        cuong.girlFriendName = "Joan"
        let CuongGirlFriendName = cuong.girlFriendName ?? "Jane"
        writeln(CuongGirlFriendName)
    }

}
