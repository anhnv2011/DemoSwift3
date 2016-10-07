//
//  DetailVC.swift
//  SectionIndexContact
//
//  Created by hoangdangtrung on 1/15/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var person = Person()
    
    var labelName = UILabel()
    var labelMobileBlue = UILabel()
    var labelPhoneNumber = UILabel()
    var imagePhone = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.labelName.frame = CGRect(x: 30, y: 100, width: 300, height: 50)
        self.labelName.font = UIFont.boldSystemFont(ofSize: 25)
        
        
        self.labelMobileBlue.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        self.labelMobileBlue.text = "mobile"
        self.labelMobileBlue.textColor = UIColor.blue
        
        self.labelPhoneNumber.frame = CGRect(x: 30, y: 220, width: 200, height: 30)
        
        self.imagePhone.image = UIImage(named: "phone")
        self.imagePhone.frame = CGRect(x: self.view.bounds.size.width - 100, y: 210, width: 79, height: 38)
        
        self.view.addSubview(self.labelName)
        self.view.addSubview(self.labelMobileBlue)
        self.view.addSubview(self.labelPhoneNumber)
        self.view.addSubview(self.imagePhone)
        
        self.setTextForLabelName(person.middleName + " " + person.firstName, phone: person.mobilePhone)
        
    }
    
    func setTextForLabelName(_ name: String, phone: String) {
        self.labelPhoneNumber.text = phone
        self.labelName.text = name

    }


}
