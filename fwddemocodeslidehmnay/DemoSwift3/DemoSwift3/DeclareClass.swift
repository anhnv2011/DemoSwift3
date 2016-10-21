//
//  DeclareClass.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/21/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit

enum ValidationError: Error {
    case PasswordToShort()
}

//Hoàn toàn là Swift class
class Person {
    var name: String
    var age: Int
    //Có 4 cấp độ: public, internal, private, fileprivate
    private var password: String
    
    internal var taxCode: String  //try to replace internal by fileprivate
    
    
    //computed property
    var nickName: String? {
        get {
            return self.nickName
        }
        
        set (newNickName) {
           if (newNickName?.characters.count)! > 6 {
             //throw ValidationError.PasswordToShort()  cannot throw in setter function
             //http://stackoverflow.com/questions/32899346/how-do-i-declare-that-a-computed-property-throws-in-swift-2
                self.nickName = newNickName
           }
        }
    }
    
    init(name: String, age: Int, taxCode: String) {
        self.name = name
        self.age = age
        self.taxCode = taxCode
        self.password = "@qwnerqwjenrqw"
    }
    
    func sayName() {
        print(name)
    }
    
    deinit {
        print("Clean up memory")
        
    }
}

final class BarackObama: Person {
    
}


//kế thừa NSObject
class objPerson : NSObject {
    
}
class DeclareClass: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        let john = Person.init(name: "Job", age: 20, taxCode: "2123434")
        john.sayName()
        print("John tax code \(john.taxCode)")
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View disappeared")
    }
  
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        print("Dismiss")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("View will disappear")
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("unwind")
    }
    
    deinit {
        print ("Deinit")
    }

    
}
