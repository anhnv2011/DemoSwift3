//
//  ContactListVC.swift
//  NSURLSession
//
//  Created by Vinh The on 7/26/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

let URL : String! = "http://localhost:2403/information/"

class ContactListVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var informations = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        navigationItem.title = "Contact List"
        navigationItem.rightBarButtonItem = addBarButton()
        
        getInformationRequest()
    }
    
    // MARK: TableView configuration
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! DetailContactCell
        
        let personInformation = informations[(indexPath as NSIndexPath).row]
        cell.updateUI(personInformation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            self.deleteContactRequest(indexPath)
        }
        
        deleteAction.backgroundColor = UIColor(red: 244/255, green: 117/255, blue: 100/255, alpha: 1.0)
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            let addNewContact = self.storyboard?.instantiateViewController(withIdentifier: "AddNewContactVC") as! AddNewContactVC
            
            addNewContact.delegate = self
            addNewContact.isEditting = true
            addNewContact.currentPerson = self.informations[(indexPath as NSIndexPath).row]
            self.displayContentController(addNewContact)
            
        }
        
        return [deleteAction, editAction]
    }
    //MARK: Create BarButton
    
    func addBarButton() -> UIBarButtonItem{
        
        let addNewContactBarButton = UIBarButtonItem(image: UIImage(named: "Add New Bar Button")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addNewContact(_:)))
        
        return addNewContactBarButton
    }
    
    func addNewContact(_ sender : AnyObject) {
        let addNewContact = storyboard?.instantiateViewController(withIdentifier: "AddNewContactVC") as! AddNewContactVC
        
        addNewContact.delegate = self
        addNewContact.isEditting = false
        
        displayContentController(addNewContact)
        
    }
    
    //MARK: Request methods
    
    func getInformationRequest(){
        let urlRequest = URLRequest(url: Foundation.URL(string: URL)!)
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? HTTPURLResponse{
                    if responseHTTP.statusCode == 200{
                        guard let information = data else {return}
                        
                        do{
                            let result = try JSONSerialization.jsonObject(with: information, options: JSONSerialization.ReadingOptions.allowFragments)
                            
                            print(result)
                            
                            if let arrayResult : AnyObject = result as AnyObject? {
                                for infoDict in arrayResult as! [AnyObject]{
                                    if let infoDict = infoDict as? [String : AnyObject]{
                                        print(infoDict)
                                        self.informations.append(Person.init(information: infoDict))
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.myTableView.reloadData()
                                        })
                                        
                                    }else{
                                        
                                    }
                                }
                            }
                            
                        }catch let error as NSError{
                            print(error.description)
                        }
                        
                    }else{
                        print(responseHTTP.statusCode)
                    }
                }
            }
            
            }) .resume()
    }
    
    
    func deleteContactRequest(_ indexPath: IndexPath){
        let id = informations[(indexPath as NSIndexPath).row].id
        
        let urlRequest = NSMutableURLRequest(url: Foundation.URL(string: URL + id!)!)
        
        urlRequest.httpMethod = "DELETE"
        
        let session = URLSession.shared
    
        session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        self.informations.remove(at: (indexPath as NSIndexPath).row)
                        DispatchQueue.main.async(execute: {
                            self.myTableView.deleteRows(at: [indexPath], with: .automatic)
                        })
                    }else{
                        print(httpResponse.statusCode)
                    }
                }
            }
        }) .resume()
    }
    // MARK: Create Popup
    
    var blurView : UIView?
    var popUpVC : AddNewContactVC?
    
    func createBlurView() -> UIView {
        let blurView = UIView(frame: view.bounds)
        blurView.backgroundColor = UIColor.black
        blurView.alpha = 0.5
        
        return blurView
    }
    
    func displayContentController(_ content : AddNewContactVC) {
        
        popUpVC = content
        
        blurView = createBlurView()
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDismissGesture(_:)))
        blurView?.addGestureRecognizer(dismissTapGesture)
        
        view.addSubview(blurView!)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        addChildViewController(content)
        content.view.bounds = CGRect(x: 0, y: 0, width: view.bounds.width / 1.2, height: view.bounds.height / 1.3)
        content.view.alpha = 0.5
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: {
            
            content.view.alpha = 1.0
            content.view.center = CGPoint(x: self.view.bounds.width / 2.0, y: self.view.bounds.height / 2.0)
            self.view.addSubview(content.view)
            content.didMove(toParentViewController: self)
            
            }, completion: nil)
        
    }
    
    
    
    func animateDismissAddNewContactView(_ addNewVC : AddNewContactVC) {
        let bounds = addNewVC.view.bounds
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            
            addNewVC.view.alpha = 0.5
            addNewVC.view.center = CGPoint(x: self.view.bounds.width / 2.0, y: -bounds.height)
            self.blurView?.alpha = 0.0
            
        }){(Bool) in
            addNewVC.view.removeFromSuperview()
            addNewVC.removeFromParentViewController()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.blurView?.removeFromSuperview()
        }
        
    }
    
    func tapDismissGesture(_ tapGesture : UITapGestureRecognizer) {
        animateDismissAddNewContactView(popUpVC!)
    }
}

//MARK: Delegate

extension ContactListVC : AddNewContactDelegate{
    func dismissAddNewController(_ addNewVC: AddNewContactVC) {
        animateDismissAddNewContactView(addNewVC)
        
        informations.removeAll()
        getInformationRequest()
    }
}



