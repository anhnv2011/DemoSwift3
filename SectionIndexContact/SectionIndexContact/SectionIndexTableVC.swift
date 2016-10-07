//
//  SectionIndexTableVC.swift
//  SectionIndexContact
//
//  Created by hoangdangtrung on 1/12/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class SectionIndex_TableVC: UITableViewController {
    
    var arrayData: NSMutableArray!
    var dictContact = NSMutableDictionary()
    var arrayKey : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionIndexBackgroundColor = UIColor.gray /* Change Section Index Background Color */
        self.tableView.sectionIndexColor = UIColor.white /* Change Section Index Color (A...B...C...) */
        self.tableView.sectionIndexTrackingBackgroundColor = UIColor.black /* Highlight Color when user tap to Section Index */
        
        arrayData = NSMutableArray()
        for i in 0...60 {
            arrayData.add(Person())
            let person = arrayData[i] as! Person
            print(person.fullName)
        }
        
        for element in arrayData { // Truy xuất lần lượt từng phần tử trong mảng arrayData
            let person: Person = element as! Person //
            var firstLetter: String = (person.firstName as NSString!).substring(to: 1) // Khai báo 1 string và gán giá trị là kí tự đầu tiên trong string firstName
            if firstLetter == "Đ" {
                firstLetter = "D"
            }
            if firstLetter == "Á" {
                firstLetter = "A"
            }
            
            var arrayForLetter: NSMutableArray! // Khai báo mảng để chứa các đối tượng person có firstName tương ứng với firstLetter. Ví dụ firstLetter là chữ B, thì arrayForLetter sẽ chứa các đối tượng person có firstName bắt đầu = chữ B
            
            if (dictContact.value(forKey: firstLetter) != nil) { // Kiểm tra nếu value tương ứng với key trong dictContacts mà tồn tại giá trị thì...
                arrayForLetter = dictContact.value(forKey: firstLetter) as! NSMutableArray //Gán giá trị đó đến mảng arayForLetter
                arrayForLetter.add(person) //Sau đó add thêm đối tượng person đến arrayForLetter
                dictContact.setValue(arrayForLetter, forKey: firstLetter) //Rồi truyền ngược trở lại arrayForLetter đó đến value tương ứng với key trong dictContacts
            } else { // Trong trường hợp value tương ứng với key trong dictContacts mà bằng nil
                arrayForLetter = NSMutableArray(object: person) // Gán đối tượng person đến mảng arrayForLetter
                dictContact.setValue(arrayForLetter, forKey: firstLetter) // Sau đó set value cho dictContacts là arrayForLetter tương ứng với key là firstLetter
            }
            
        }
        arrayKey = dictContact.allKeys as! [String] // Lấy ra mảng chứa tất cả các key tron dictContacts
        arrayKey = arrayKey.sorted()
        
        
    }
    
<<<<<<< HEAD
=======
}

extension SectionIndex_TableVC{
    
>>>>>>> c11c927d6892da97d01b375a443f407af9227d31
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayKey.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = arrayKey[section]
        
        let sectionPersons = dictContact.object(forKey: sectionTitle) as! NSArray
        
        return sectionPersons.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayKey[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrayKey
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.gray
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        let sectionTitle = arrayKey[indexPath.section]
        
        let sectionPersons = dictContact[sectionTitle] as! NSArray
        
        let person = sectionPersons[indexPath.row] as! Person
        
        cell!.textLabel?.text = person.fullName
        
        cell!.detailTextLabel?.text = person.mobilePhone
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailVC()
        
        let sectionTitle = arrayKey[(indexPath as NSIndexPath).section]
        
        let sectionPersons = dictContact[sectionTitle]
        
        let person = sectionPersons as! Person
        
        detailVC.person = person
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}








<<<<<<< HEAD

=======
>>>>>>> c11c927d6892da97d01b375a443f407af9227d31
