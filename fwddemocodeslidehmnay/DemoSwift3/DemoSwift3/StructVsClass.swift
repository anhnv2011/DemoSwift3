//
//  StructVsClass.swift
//  DemoSwift3
//
//  Created by Techmaster on 9/28/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

import UIKit
struct Point {
    var x, y: Double
    func draw() {
        
    }
}

/* struct không có tính kế thừa. Điều này đúng trong Swift, không có nghĩa là đúng với C++
 struct Point3D: Point {
    var z: Double
}
*/

class Diem {
    var x: Double = 0.0
    var y: Double = 0.0
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

//Class có thể kế thừa
class Diem3D : Diem {
    var z: Double = 0.0
}
class StructVsClass: ConsoleScreen {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         Đối với struct, vùng nhớ được cấp phát ở stack. Các property sẽ nối tiếp nhau.
         Tốc độ cấp phát sẽ rất nhanh, gần như khi chúng ta khởi tạo biến primitive data type
         struct là value type có nghĩa khi gán struct này vào struct kia, chương trình sẽ copy tạo mới struct
         */
        
        // & lay ra dia chi
        var point1 = Point(x: 1.0, y: 2.0)
        var point2 = point1
        withUnsafePointer(to: &point1) {
            writeln("Address of point1 struct: \($0)")
        }
        withUnsafePointer(to: &point2) {
            writeln("Address of point2 struct: \($0)")
        }
        
        
        writeln("")
        /*
         Đối tượng tạo ra từ Class được cấp phát ở vùng nhớ Heap. Để truy vấn đối tượng ở heap phải dùng con trỏ.
         Khi cấp phát vùng nhớ heap, hệ thống phải tìm kiếm xem vùng nhớ heap (dạng thủng lỗ chỗ) còn ô nào chống phù hợp thì sẽ cấp phát
         
         Khi gán con trỏ thì không copy đối tượng mới mà chỉ chỉnh đích trỏ đến của con trỏ
        */
        var diem1 = Diem(x: 1.0, y: 2.0)
        var diem2 = diem1
        //In ra địa chỉ vùng nhớ stack của biến con trỏ chứ không phải địa chỉ của đối tượng mà con trỏ trỏ đến
        withUnsafePointer(to: &diem1) {
            writeln("Address of diem1 pointer: \($0)")
        }
        withUnsafePointer(to: &diem2) {
            writeln("Address of diem2 pointer: \($0)")
        }
        /*
         Để lấy địa chỉ đối tượng thực sự trong heap trong Swift 3 dùng hàm Unmanaged.passUnretained(obj).toOpaque()
        */
        writeln("")
        writeln("Address of diem1 object: \(Unmanaged.passUnretained(diem1).toOpaque())")
        writeln("Address of diem1 object: \(Unmanaged.passUnretained(diem2).toOpaque())")
        
        //HomeWork: Hãy thử quan sát cách đánh địa chỉ trong vùng nhớ Stack và Heap
     
    }

}
