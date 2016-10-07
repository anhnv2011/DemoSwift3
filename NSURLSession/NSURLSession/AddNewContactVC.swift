//
//  AddNewContactVC.swift
//  NSURLSession
//
//  Created by Vinh The on 7/27/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

protocol AddNewContactDelegate {
    func dismissAddNewController(_ addNewVC : AddNewContactVC)
}

class AddNewContactVC: UIViewController{
    
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var phoneTextField: CustomTextField!
    
    @IBOutlet weak var cityTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var navLabel: UILabel!
    var delegate : AddNewContactDelegate?
    
    @IBOutlet weak var addButton: UIButton!
    
    var isEditting : Bool?
    var currentPerson : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        cityTextField.delegate = self
        emailTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        editContact(currentPerson)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setMask(view, rectCorner: [.bottomLeft,.bottomRight, .topLeft, .topRight], radius: CGSize(width: 20.0, height: 20.0))
        setMask(bannerView, rectCorner: [.topLeft, .topRight], radius: CGSize(width: 20.0, height: 20.0))
        
    }
    
    func editContact(_ person : Person?){
        if let personContact = person {
            
            if let name = personContact.name, let phone = personContact.phone, let city = personContact.city, let email = personContact.email{
                nameTextField.text = name
                phoneTextField.text = String(phone)
                cityTextField.text = city
                emailTextField.text = email
            }
            
            addButton.setTitle("EDIT", for: UIControlState())
            navLabel.text = "Edit Contact"
        }
    }
    // MARK: POST Request - Create New Contact
    
    func createNewContactRequest(_ name : String, phone : Int, city : String?, email: String?){
        
        var param : [String:AnyObject] = ["Name": name as AnyObject, "PhoneNumber" : phone as AnyObject]
        
        if city != nil{
            param["City"] = city as AnyObject?
        }
        if email != nil{
            param["Email"] = email as AnyObject?
        }
        
        let urlRequest = NSMutableURLRequest(url: Foundation.URL(string: URL)!)
        
        urlRequest.httpMethod = "POST"
        
        let configureSession = URLSessionConfiguration.default
        
        configureSession.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        let createContactSession = URLSession(configuration: configureSession)
        
        let dataPassing = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        createContactSession.uploadTask(with: urlRequest as URLRequest, from: dataPassing, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        print("Data : \(data)")
                        
                        DispatchQueue.main.async(execute: {
                            self.delegate?.dismissAddNewController(self)
                        })
                        
                    }else{
                        print(httpResponse.statusCode)
                    }
                }
            }
            }) .resume()
        
    }
    
    // MARK : EDIT Request
    
    func editContactRequest(_ name : String, phone : Int, city : String?, email: String?, id : String){
        
        var param : [String:AnyObject] = ["Name": name as AnyObject, "PhoneNumber" : phone as AnyObject]
        
        if city != nil{
            param["City"] = city as AnyObject?
        }
        if email != nil{
            param["Email"] = email as AnyObject?
        }
        
        let urlRequest = NSMutableURLRequest(url: Foundation.URL(string: URL + id)!)
        
        urlRequest.httpMethod = "PUT"
        
        let configureSession = URLSessionConfiguration.default
        
        configureSession.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        let createContactSession = URLSession(configuration: configureSession)
        
        let dataPassing = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        createContactSession.uploadTask(with: urlRequest as URLRequest, from: dataPassing, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        print("Data : \(data)")
                        
                        DispatchQueue.main.async(execute: {
                            self.delegate?.dismissAddNewController(self)
                        })
                        
                    }else{
                        print(httpResponse.statusCode)
                    }
                }
            }
            }) .resume()
        
    }

    
    // MARK: Create corner roundrect.
    
    func setMask(_ view : UIView, rectCorner : UIRectCorner, radius : CGSize){
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: rectCorner, cornerRadii: radius)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.borderWidth = 1.0
        maskLayer.borderColor = UIColor.black.cgColor
        
        view.layer.mask = maskLayer
        
    }
    
    @IBAction func addNewContactAction(_ sender: AnyObject) {
        
        if isEditting == true {
            if let name = nameTextField.text, let phone = Int(phoneTextField.text!) {
                editContactRequest(name, phone: phone, city: cityTextField.text, email: emailTextField.text, id: (currentPerson?.id)!)
            }else{
                print("no name no phone")
            }

        }else{
            if let name = nameTextField.text, let phone = Int(phoneTextField.text!) {
                print(cityTextField.text)
                createNewContactRequest(name, phone: phone, city: cityTextField.text, email:emailTextField.text)
            }else{
                print("no name no phone")
            }
        }
        
    }
}


extension AddNewContactVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setValue(UIColor.clear, forKeyPath: "_placeholderLabel.textColor")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setValue(UIColor.black, forKeyPath: "_placeholderLabel.textColor")
    }
}
