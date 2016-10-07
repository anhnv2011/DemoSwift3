//
//  ViewController.swift
//  ConvertPlistToStrings
//
//  Created by TuNguyen on 5/1/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        convertStringsToPlist("/Users/tuuu/Desktop/untitled folder 2/FAQs.strings")//Truyền đường dẫn để chuyển từ String sang Plist
        //        convertPlistToStrings(fileName)//Calling this func is you want to convert strings - > plist
        //helpData is file name .strings
    }
    
    func convertPlistToStrings(_ path:NSString)
    {
        guard let array = NSArray(contentsOfFile: path as String )
            else
        {
            return
        }
        
        var content = ""
        //Duyệt các phần tử trong file plist
        for dict in array
        {
            //Lấy ra giá trị ứng với mỗi key của mỗi phần tử
            for key in (dict as AnyObject).allKeys
            {
                //lây ra giá trị vào thêm vào xâu ký tự để sau nay có thể ghi ra file strings
                if let subArray = (dict as AnyObject).value(forKey: key as! String) as? NSArray {
                    content = content + "--\(key)\n"
                    for value in subArray {
                        content = content + "+\(value)\n"
                    }
                }
                else
                {
                    if let value =  (dict as AnyObject).value(forKey: key as! String) {
                        content = content + "--\(key)\n+\(value)\n"
                    }
                }
            }
            content = content + "\n-------\n"
            
            
            //this path to your desktop
            //(fileName).strings is file name after converting
            let newPath = path.deletingPathExtension + ".strings"
            do
            {
                try content.write(toFile: newPath, atomically: false, encoding: String.Encoding.utf8);
            }
            catch let error as NSError
            {
                print("Error:" + error.localizedDescription)
            }
            
        }
    }
    func convertStringsToPlist(_ path: NSString)
    {
        var nsstringContent = ""
        do
        {
            //lấy dữ liệu từ .strings file
            try nsstringContent = NSString(contentsOfFile: path as String, encoding: String.Encoding.utf8.rawValue) as String
        }
        catch let error as NSError
        {
            print("Error:" + error.localizedDescription)
        }
        //Tách ra các phần tử để convert ngược lại
        let array = nsstringContent.components(separatedBy: "\n-------\n")
        var arrayPlist = [NSMutableDictionary]();
        /*Duyệt mỗi phần tử để ghép lại thành 1 dictionary sau đó thêm vào
         dictionary tổng để ghi ra .plist file
         */
        for value in array
        {
            let dictData = NSMutableDictionary()
            //kiểm tra chắc chắn cái dòng chúng ta đọc != rỗng
            if value.characters.count > 1{
                //Lấy ra mỗi dictionary con
                let aDict = value.components(separatedBy: "\n")
                var key = ""
                var valuesArray = [String]()
                var content = ""
                func addContentOfKey()
                {
                    let value = valuesArray.last
                    valuesArray.removeLast()
                    valuesArray.append(value! + "\n" + content)
                    content = ""
                }
                for data in aDict
                {
                    if (data == "")
                    {
                        continue
                    }
                    //Nếu mà là dấu "--" có nghĩa là key và "+" có nghĩa là value
                    if (NSString(string: data).substring(with: NSRange(location: 0, length: 2)) == "--") {
                        if (content != "")
                        {
                            addContentOfKey()
                        }
                        let index = data.characters.index(data.startIndex, offsetBy: 2)
                        if (valuesArray.count > 0) {
                            if valuesArray.count == 1 {
                                dictData.setValue(valuesArray.first!, forKey: key)
                            }
                            else
                            {
                                dictData.setValue(valuesArray, forKey: key)
                            }
                            valuesArray = [String]()
                        }
                        key = data.substring(from: index)
                    }
                    else if (data.characters.first == "+") {
                        let index = data.characters.index(data.startIndex, offsetBy: 1)
                        if (content != "")
                        {
                            addContentOfKey()
                        }
                        
                        valuesArray.append(data.substring(from: index))
                        
                    }
                    else
                    {
                        content = content != "" ? content + "\n" + data : data
                    }
                }
                if (content != "")
                {
                    addContentOfKey()
                }
                if (key.characters.count > 1 && valuesArray.count > 0) {
                    if valuesArray.count == 1 {
                        dictData.setValue(valuesArray.first!, forKey: key)
                    }
                    else
                    {
                        dictData.setValue(valuesArray, forKey: key)
                    }
                    valuesArray = [String]()
                }
                arrayPlist.append(dictData)
            }
            
        }
        let arrayToWrite = NSArray(array: arrayPlist)
        ///Users/dangcan/Desktop/\(fileName).plist is the path after the .strings file convert completely with name is (fileName).plist
        let newPath = path.deletingPathExtension + ".plist"
        arrayToWrite.write(toFile: newPath, atomically: true)
    }
}

