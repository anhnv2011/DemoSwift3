//
//  LoginViewController.swift
//  NavController-TabbarController
//
//  Created by Vinh The on 7/15/16.
//  Copyright © 2016 Vinh The. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var LogoToTopViewContraint: NSLayoutConstraint!

    var users : [User]!
    
    var isAuthenticated : Bool!
    
    @IBOutlet weak var usernameInputTextField: CustomTextField!
    
    
    @IBOutlet weak var passwordInputTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateContraint(LogoToTopViewContraint)
        
        tranparentNavigation = true
        
        backButtonTitle = ""
        
        createUser()
    }
    
    @IBAction func signUpAction(_ sender: AnyObject) {
        
        let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
        
    }

    @IBAction func loginAction(_ sender: AnyObject) {
        checkUserAuth()
    }
    
    func createUser() {
        let user1 = User(name: "sunsunai", password: "123456")
        let user2 = User(name: "lucio", password: "123456")
        let user3 = User(name: "lucia", password: "123456")
        
        users = [user1, user2, user3]
    }
    
    func checkUserAuth(){
        for user in users {
            
            guard let username = user.name else {return}
            guard let password = user.password else {return}
            
            guard let usernameTextField = usernameInputTextField.text else {return}
            guard let passwordTextField = passwordInputTextField.text else {return}
            
            if username == usernameTextField && password == passwordTextField{
                isAuthenticated = true
                break
            }else{
                isAuthenticated = false
            }
        }
        
        if isAuthenticated == true{

            let tabbar = BaseTabbarController()
            
            present(tabbar, animated: true, completion: nil)
            
        }else{
            let alertController = UIAlertController(title: "Error", message: "No Information", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
