//
//  RegisterViewController.swift
//  funChat
//
//  Created by David Zielski on 5/17/16.
//  Copyright © 2016 mobiledez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    var newUser: BackendlessUser?
    var email: String?
    var username: String?
    var password: String?
    var avatarImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newUser = BackendlessUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: IBActions
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != ""
        {
            ProgressHUD.show("Registering...")
            email = emailTextField.text
            username = usernameTextField.text
            password = passwordTextField.text
            
            register(self.email!, username: self.username!, password: self.password!, avatarImage: avatarImage)
        }
        else
        {
            ProgressHUD.showError("All fields are required")
        }
            
    }
    
    
    //MARK: Backendless user registration
    
    func register(email: String, username: String, password: String, avatarImage: UIImage?)
    {
        if avatarImage == nil
        {
            newUser!.setProperty("Avatar", object: "")
        }
        
        newUser!.email = email
        newUser!.name = username
        newUser!.password = password
        
        backendless.userService.registering(newUser, response: { (registeredUser : BackendlessUser!) -> Void in
            
            ProgressHUD.dismiss()
            
            //login new user
            self.loginUser(email, username: username, password: password)
            
            self.usernameTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            
        }) { (fault : Fault!) -> Void in
                print("Server reported and error, could not register new user: \(fault) ")
        }
        
    }
    
    func loginUser(email: String, username: String, password: String)
    {
        backendless.userService.login(email, password: password, response: { (user : BackendlessUser!) -> Void in
            
            // here segue to recents vc
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            vc.selectedIndex = 0  //default to first one
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }) { (fault : Fault!) -> Void in
            print("Server reported and error: \(fault) ")
        }
        
        
        
        
    }
}
