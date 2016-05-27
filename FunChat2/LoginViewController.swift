//
//  LoginViewController.swift
//  funChat
//
//  Created by David Zielski on 5/17/16.
//  Copyright © 2016 mobiledez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    var email: String?
    var password: String?    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Mark: IBActions
    @IBAction func loginBarButtonTapped(sender: UIBarButtonItem)
    {
        if emailTextField.text != "" && passwordTextField.text != ""
        {
            ProgressHUD.show("Logging In...")

            email = emailTextField.text
            password = passwordTextField.text
            
            loginUser(self.email!, password: self.password!)
        }
        else
        {
            ProgressHUD.showError("All fields are required")
        }

    }

    
    func loginUser(email: String, password: String)
    {
        backendless.userService.login(email, password: password, response: { (user : BackendlessUser!) -> Void in
            
            ProgressHUD.dismiss()
            
            // here segue to recents vc
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            vc.selectedIndex = 0  //default to first one
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }) { (fault : Fault!) -> Void in
            print("Server reported and error: \(fault) ")
        }
        
        
        
        
    }
    
    
    
}
