//
//  Subscript.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/29/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//  subscript là dạng truy xuất kiểu getter / setter function với cú pháp [index]

import UIKit

struct IPv4 {
    var num1, num2, num3, num4: Int
  
    subscript(index: Int) -> Int {
        get {
            switch index {
            case 1:
                return num1
            case 2:
                return num2
            case 3:
                return num3
            case 4:
                return num4
            default:
                return -1
            }
        }
        set(newValue) {
            switch index {
            case 1:
                num1 = newValue
            case 2:
                num2 = newValue
            case 3:
                num3 = newValue
            case 4:
                num4 = newValue
            default:
                return
            }
        }
    }
}
/*
 Lấy ra một từ trong một đoạn văn
 */
class Paragraph {
    var text: String
    private var words: [String]
    
    init (text: String) {
        self.text = text
        words = text.characters.split{$0 == " "}.map(String.init)

    }
    
    subscript(index: Int) -> String? {
        get {
            if index > words.count {
                return nil
            } else {
                return words[index]
            }
            
        }
    }
    
    /* let text = "In Swift 2 the use of split becomes a bit more complicated due to the introduction of the internal CharacterView type. This means that String no longer adopts the SequenceType or CollectionType protocols and you must instead use the .characters property to access a CharacterView type representation of a String instance. (Note: CharacterView does adopt SequenceType and CollectionType protocols)."
     
     let words: [String] = text.characters.split{$0 == " "}.map(String.init)
     words.forEach {
     self.writeln($0)
     }*/
    
    
}


enum DayOfWeek: Int {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

enum Language {
    case English
    case Vietnamese
}


struct Today {
    var day: DayOfWeek
    static let DayOfWeekVN = ["Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật"]
    static let DayOfWeekEN = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    /*
     Trong ví dụ này, subscript có thể nhận vào kiểu enumeration
     */
    subscript(index: Language) -> String {
        get {
            switch index {
            case .English:
                return Today.DayOfWeekEN[day.rawValue]
            case .Vietnamese:
                return Today.DayOfWeekVN[day.rawValue]
            }
        }
    }
}

// Subscript chơi được cả với index kiểu struct. Sợ vãi đ*i mấy ông thiết kế Swift!
struct X_Y {
    var x, y: Int
}
class MagicPoints {
    subscript (index: X_Y) -> Int {
        get {
            return 0
        }
    }
}

//-------------------------------------
class Subscript: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()
        //demo 1
        let myIP = IPv4(num1:192, num2: 168, num3: 1, num4: 1)
        writeln("First component \(myIP[1])")
        writeln("Last component \(myIP[4])")
        //Bài tập hãy thử thay đổi struct này nhận vào string để tạo nên IP struct
        
        //demo 2
        let paragraph = Paragraph(text: "In Swift 2 the use of split becomes a bit more complicated due to the introduction of the internal CharacterView type. This means that String no longer adopts the SequenceType or CollectionType protocols and you must instead use the .characters property to access a CharacterView type representation of a String instance. (Note: CharacterView does adopt SequenceType and CollectionType protocols).")
        writeln(paragraph[1]!)
        
        
        //demo 3
        let today = Today(day: .Sunday)
        writeln("\(today[Language.Vietnamese])")


    }

    

}
